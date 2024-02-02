require 'rails_helper'

RSpec.describe Manager::UsersController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  let(:user) { create(:user, role: :employee, company: admin_user.company) }

  before do
    sign_in admin_user
    ActsAsTenant.current_tenant = admin_user.company
  end

  describe 'GET #index' do
    it 'assigns all users to @users' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(assigns(:users)).to eq([user])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      get :show, params: { id: user.id }

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user to @user' do
      get :new

      expect(response).to be_successful
      expect(response).to render_template(:new)
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
        expect(response).to redirect_to manager_user_path(User.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect do
          post :create, params: { user: { name: nil } }
        end.not_to change(User, :count)
        expect(response).to render_template(:new)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested user to @user' do
      get :edit, params: { id: user.id }

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PATCH #update' do
    let(:new_name) { FFaker::Name.name }

    context 'with valid parameters' do
      it 'updates the requested user' do
        patch :update, params: { id: user.id, user: { name: new_name } }

        user.reload
        expect(user.name).to eq(new_name)
        expect(response).to redirect_to manager_user_path(user)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested user' do
        patch :update, params: { id: user.id, user: { name: nil } }
        user.reload
        expect(user.name).not_to be_nil
        expect(response).to render_template(:edit)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'destroys the requested user' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
      expect(response).to redirect_to manager_users_url
    end
  end
end
