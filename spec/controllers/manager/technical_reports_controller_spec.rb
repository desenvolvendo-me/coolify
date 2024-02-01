require 'rails_helper'

RSpec.describe Manager::TechnicalReportsController, type: :controller do
  let(:admin_user) { create(:user, role: :admin) }
  before do
    sign_in admin_user
    ActsAsTenant.current_tenant = admin_user.company
  end

  describe 'GET #new' do
    it 'assigns a new technical_report as @technical_report' do
      get :new
      expect(assigns(:technical_report)).to be_a_new(TechnicalReport)
    end
  end

end
