require 'rails_helper'

RSpec.describe Manager::MaintenancePlansController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  let(:maintenance_plan) { create(:maintenance_plan, company: admin_user.company) }

  before do
    sign_in admin_user
    ActsAsTenant.current_tenant = admin_user.company
  end

  describe 'GET #index' do
    it 'assigns all maintenance_plans to @maintenance_plans' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(assigns(:maintenance_plans)).to eq([maintenance_plan])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested maintenance_plan to @maintenance_plan' do
      get :show, params: { id: maintenance_plan.id }

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(assigns(:maintenance_plan)).to eq(maintenance_plan)
    end
  end

  describe 'GET #new' do
    it 'assigns a new maintenance_plan to @maintenance_plan' do
      get :new

      expect(response).to be_successful
      expect(response).to render_template(:new)
      expect(assigns(:maintenance_plan)).to be_a_new(MaintenancePlan)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new maintenance_plan' do
        expect do
          post :create, params: { maintenance_plan: attributes_for(:maintenance_plan) }
        end.to change(MaintenancePlan, :count).by(1)
        expect(response).to redirect_to manager_maintenance_plan_path(MaintenancePlan.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new maintenance_plan' do
        expect do
          post :create, params: { maintenance_plan: { name: nil } }
        end.not_to change(MaintenancePlan, :count)
        expect(response).to render_template(:new)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested maintenance_plan to @maintenance_plan' do
      get :edit, params: { id: maintenance_plan.id }

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(assigns(:maintenance_plan)).to eq(maintenance_plan)
    end
  end

  describe 'PATCH #update' do
    let(:new_name) { FFaker::Lorem.word }

    context 'with valid parameters' do
      it 'updates the requested maintenance_plan' do
        patch :update, params: { id: maintenance_plan.id, maintenance_plan: { name: new_name } }

        maintenance_plan.reload
        expect(maintenance_plan.name).to eq(new_name)
        expect(response).to redirect_to manager_maintenance_plan_path(maintenance_plan)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested maintenance_plan' do
        patch :update, params: { id: maintenance_plan.id, maintenance_plan: { name: nil } }
        maintenance_plan.reload
        expect(maintenance_plan.name).not_to be_nil
        expect(response).to render_template(:edit)
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:maintenance_plan) { create(:maintenance_plan) }

    it 'destroys the requested maintenance_plan' do
      expect do
        delete :destroy, params: { id: maintenance_plan.id }
      end.to change(MaintenancePlan, :count).by(-1)
      expect(response).to redirect_to manager_maintenance_plans_url
    end
  end
end
