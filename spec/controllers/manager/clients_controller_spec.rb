require 'rails_helper'

RSpec.describe Manager::ClientsController, type: :controller do
  let(:client) { create(:client) }

  describe 'GET #index' do
    it 'assigns all clients to @clients' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(assigns(:clients)).to eq([client])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested client to @client' do
      get :show, params: { id: client.id }

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(assigns(:client)).to eq(client)
    end
  end

  describe 'GET #new' do
    it 'assigns a new client to @client' do
      get :new

      expect(response).to be_successful
      expect(response).to render_template(:new)
      expect(assigns(:client)).to be_a_new(Client)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new client' do
        expect do
          post :create, params: { client: attributes_for(:client) }
        end.to change(Client, :count).by(1)
        expect(response).to redirect_to manager_client_path(Client.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new client' do
        expect do
          post :create, params: { client: { name: nil } }
        end.not_to change(Client, :count)
        expect(response).to render_template(:new)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested client to @client' do
      get :edit, params: { id: client.id }

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(assigns(:client)).to eq(client)
    end
  end

  describe 'PATCH #update' do
    let(:new_name) { FFaker::Name.name }

    context 'with valid parameters' do
      it 'updates the requested client' do
        patch :update, params: { id: client.id, client: { name: new_name } }

        client.reload
        expect(client.name).to eq(new_name)
        expect(response).to redirect_to manager_client_path(client)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested client' do
        patch :update, params: { id: client.id, client: { name: nil } }
        client.reload
        expect(client.name).not_to be_nil
        expect(response).to render_template(:edit)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:client) { create(:client) }

    it 'destroys the requested client' do
      expect do
        delete :destroy, params: { id: client.id }
      end.to change(Client, :count).by(-1)
      expect(response).to redirect_to manager_clients_url
    end
  end
end
