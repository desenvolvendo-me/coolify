require 'rails_helper'

RSpec.describe Manager::CompaniesController, type: :controller do
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }

  before do
    sign_in user
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    it 'updates the company and redirects to show' do
      patch :update, params: { company: { cnpj: '77.851.018/0001-21' } }
      expect(response).to redirect_to(manager_company_url)
      expect(flash[:notice]).to eq(I18n.t('manager.companies.update'))
      expect(company.reload.cnpj).to eq('77.851.018/0001-21')
    end

    it 'renders edit template if update fails' do
      allow_any_instance_of(Company).to receive(:update).and_return(false)
      patch :update, params: { company: { cnpj: '' } }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the company and redirects to manager_home' do
      delete :destroy
      expect(response).to redirect_to(manager_home_url)
      expect(flash[:notice]).to eq(I18n.t('manager.companies.destroy'))
      expect { company.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
