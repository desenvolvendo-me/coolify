require 'rails_helper'

RSpec.describe Manager::MaintenancesController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  let(:client) { create(:client) }
  let(:cooler) { create(:cooler, company: admin_user.company, client: client) }
  let(:maintenance) { create(:maintenance, company: admin_user.company, cooler: cooler) }
  let(:valid_attributes) { { date: Date.strptime('31-01-2024', '%d-%m-%Y'), cooler_id: cooler.id } }
  let(:invalid_attributes) { { date: nil } }

  before do
    sign_in admin_user
    ActsAsTenant.current_tenant = admin_user.company
  end

  describe 'GET #index' do
    it 'assigns all maintenances as @maintenances' do
      get :index
      expect(assigns(:maintenances)).to eq([maintenance])
    end
  end

  describe 'GET #index with search' do
    it 'returns the maintenances searched correctly' do
      # DADO
      maintenance1 = create(:maintenance,
                            date: Date.strptime('31-01-2024', '%d-%m-%Y'), company: admin_user.company, cooler: cooler)
      maintenance2 = create(:maintenance,
                            date: Date.strptime('01-02-2024', '%d-%m-%Y'), company: admin_user.company, cooler: cooler)

      # QUANDO
      get :index,
          params: {
            q: { date_eq: '31/01/2024' }
          }

      # ENTÃO
      expect(assigns(:maintenances)).to include(maintenance1)
      expect(assigns(:maintenances)).not_to include(maintenance2)
    end

    it 'excludes non-matching results' do
      create(:maintenance, date: Date.strptime('20-01-2024', '%d-%m-%Y'), company: admin_user.company, cooler: cooler)

      get :index,
          params: {
            q: { date_eq: '20/01/2023' }
          }

      expect(assigns(:maintenances)).to be_empty
    end

    it 'renders the index template' do
      get :index,
          params: {
            q: { date_eq: '20/01/2024' }
          }

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested maintenance as @maintenance' do
      get :show, params: { id: maintenance.id }
      expect(assigns(:maintenance)).to eq(maintenance)
    end
  end

  describe 'GET #new' do
    it 'assigns a new maintenance as @maintenance' do
      get :new
      expect(assigns(:maintenance)).to be_a_new(Maintenance)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested maintenance as @maintenance' do
      get :edit, params: { id: maintenance.id }
      expect(assigns(:maintenance)).to eq(maintenance)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Maintenance' do
        expect do
          post :create, params: { maintenance: valid_attributes }
        end.to change(Maintenance, :count).by(1)
      end

      it 'redirects to the created maintenance' do
        post :create, params: { maintenance: valid_attributes }
        expect(response).to redirect_to(manager_maintenance_path(Maintenance.last))
      end
    end

    context 'with invalid params' do
      it 're-renders the "new" template' do
        post :create, params: { maintenance: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested maintenance' do
        put :update,
            params: { id: maintenance.id, maintenance: valid_attributes }
        maintenance.reload
        expect(I18n.l(maintenance.date)).to eq('31/01/2024')
      end

      it 'redirects to the maintenance' do
        put :update,
            params: { id: maintenance.id, maintenance: valid_attributes }
        expect(response).to redirect_to(manager_maintenance_path(maintenance))
      end
    end

    context 'with invalid params' do
      it 're-renders the "edit" template' do
        put :update,
            params: { id: maintenance.id, maintenance: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested maintenance' do
      maintenance = create(:maintenance, cooler: cooler)
      expect do
        delete :destroy, params: { id: maintenance.id }
      end.to change(Maintenance, :count).by(-1)
    end

    it 'redirects to the maintenances list' do
      delete :destroy, params: { id: maintenance.id }
      expect(response).to redirect_to(manager_maintenances_path)
    end
  end
end
