require 'rails_helper'

RSpec.describe Manager::TechnicalReportsController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  let(:company) { create(:company) }
  let(:client) { create(:client, company: company) }

  before do
    sign_in admin_user
    ActsAsTenant.current_tenant = admin_user.company
  end

  describe 'POST #create' do
    it 'creates a new technical report' do
      expect do
        post :create, params: { client_id: client.id }
      end.to change(TechnicalReport, :count).by(1)

      expect(response).to redirect_to(manager_technical_report_path(TechnicalReport.last))
    end

    it 'redirects to manager_clients_path on failure' do
      allow_any_instance_of(TechnicalReport).to receive(:save).and_return(false)

      post :create, params: { client_id: client.id }

      expect(response).to redirect_to(manager_clients_path)
    end
  end
end
