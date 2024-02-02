require 'rails_helper'

RSpec.describe Manager::CoolersController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  let(:cooler) { create(:cooler, company: admin_user.company) }
  let(:valid_attributes) { { tag: '001' } }
  let(:invalid_attributes) { { tag: '' } }

  before do
    sign_in admin_user
    ActsAsTenant.current_tenant = admin_user.company
  end

  describe 'GET #index' do
    it 'assigns all coolers as @coolers' do
      get :index
      expect(assigns(:coolers)).to eq([cooler])
    end

    it 'excludes non-matching results' do
      create(:cooler, tag: '987')

      get :index,
          params: {
            q: {
              tag_cont:
                '002'
            }
          }

      expect(assigns(:coolers)).to be_empty
    end
  end

  describe 'GET #show' do
    it 'assigns the requested cooler as @cooler' do
      get :show, params: { id: cooler.id }
      expect(assigns(:cooler)).to eq(cooler)
    end
  end

  describe 'GET #new' do
    it 'assigns a new cooler as @cooler' do
      get :new
      expect(assigns(:cooler)).to be_a_new(Cooler)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested cooler as @cooler' do
      get :edit, params: { id: cooler.id }
      expect(assigns(:cooler)).to eq(cooler)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new cooler' do
        expect do
          post :create, params: { cooler: valid_attributes }
        end.to change(Cooler, :count).by(1)
      end

      it 'redirects to the created cooler' do
        post :create, params: { cooler: valid_attributes }
        expect(response).to redirect_to(manager_cooler_path(Cooler.last))
      end
    end

    context 'with invalid params' do
      it 're-renders the "new" template' do
        post :create, params: { cooler: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested cooler' do
        put :update, params: { id: cooler.id, cooler: valid_attributes }
        cooler.reload
        expect(cooler.tag).to eq('001')
      end

      it 'redirects to the cooler' do
        put :update, params: { id: cooler.id, cooler: valid_attributes }
        expect(response).to redirect_to(manager_cooler_path(cooler))
      end
    end

    context 'with invalid params' do
      it 're-renders the "edit" template' do
        put :update, params: { id: cooler.id, cooler: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested cooler' do
      cooler = create(:cooler)
      expect do
        delete :destroy, params: { id: cooler.id }
      end.to change(Cooler, :count).by(-1)
    end

    it 'redirects to the coolers list' do
      delete :destroy, params: { id: cooler.id }
      expect(response).to redirect_to(manager_coolers_path)
    end
  end
end
