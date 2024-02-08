require 'rails_helper'

RSpec.describe Manager::Clients::CoolersController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  let(:cooler) { create(:cooler, tag: '000111', company: admin_user.company) }
  let(:client) { cooler.client }
  let(:valid_attributes) { { tag: '000222', client_id: client.id } }
  let(:invalid_attributes) { { tag: nil } }

  before do
    sign_in admin_user
    ActsAsTenant.current_tenant = admin_user.company
  end

  describe 'GET #index' do
    it 'assigns all coolers as @coolers' do
      get :index, params: { client_id: client.id }
      expect(assigns(:coolers)).to eq([cooler])
    end
  end

  describe 'GET #index with search' do
    it 'returns the coolers searched correctly' do
      cooler1 = create(:cooler,
                       tag: '000111', client: client, company: admin_user.company)
      cooler2 = create(:cooler,
                       tag: '000222', client: client, company: admin_user.company)

      get :index,
          params: {
            q: { tag_eq: '000111' },
            client_id: client.id
          }

      # ENTÃO
      expect(assigns(:coolers)).to include(cooler1)
      expect(assigns(:coolers)).not_to include(cooler2)
    end

    it 'excludes non-matching results' do
      create(:cooler, tag: '000111', company: admin_user.company)

      get :index,
          params: {
            q: { tag_eq: '000444' },
            client_id: client.id
          }

      expect(assigns(:coolers)).to be_empty
    end

    it 'renders the index template' do
      get :index,
          params: {
            q: { tag_eq: '000111' },
            client_id: client.id
          }

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested cooler as @cooler' do
      get :show, params: { id: cooler.id, client_id: client.id }
      expect(assigns(:cooler)).to eq(cooler)
    end
  end

  describe 'GET #new' do
    it 'assigns a new cooler as @cooler' do
      get :new, params: { client_id: client.id }
      expect(assigns(:cooler)).to be_a_new(Cooler)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested cooler as @cooler' do
      get :edit, params: { id: cooler.id, client_id: client.id }
      expect(assigns(:cooler)).to eq(cooler)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Cooler' do
        expect do
          post :create, params: { cooler: valid_attributes, client_id: client.id }
        end.to change(Cooler, :count).by(2)
      end

      it 'redirects to the created cooler' do
        post :create, params: { cooler: valid_attributes, client_id: client.id }
        expect(response).to redirect_to(manager_client_cooler_path(client, Cooler.last))
      end
    end

    context 'with invalid params' do
      it 're-renders the "new" template' do
        post :create, params: { cooler: invalid_attributes, client_id: client.id }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested cooler' do
        put :update,
            params: { id: cooler.id, cooler: valid_attributes, client_id: client.id }
        cooler.reload
        expect(cooler.tag).to_not be_nil
      end

      it 'redirects to the cooler' do
        put :update,
            params: { id: cooler.id, cooler: valid_attributes, client_id: client.id }
        expect(response).to redirect_to(manager_client_cooler_path(client, cooler))
      end
    end

    context 'with invalid params' do
      it 're-renders the "edit" template' do
        put :update,
            params: { id: cooler.id, cooler: invalid_attributes, client_id: client.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested cooler' do
      cooler = create(:cooler)
      expect do
        delete :destroy, params: { id: cooler.id, client_id: client.id }
      end.to change(Cooler, :count).by(0)
    end

    it 'redirects to the coolers list' do
      delete :destroy, params: { id: cooler.id, client_id: client.id }
      expect(response).to redirect_to(manager_client_coolers_path(client))
    end
  end
end
