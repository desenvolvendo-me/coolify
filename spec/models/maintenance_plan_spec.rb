# == Schema Information
#
# Table name: maintenance_plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :string           default("to_do")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint           not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_maintenance_plans_on_client_id   (client_id)
#  index_maintenance_plans_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (company_id => companies.id)
#
require 'rails_helper'

RSpec.describe MaintenancePlan, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:maintenances).dependent(:destroy) }
  end

  describe 'enums' do
    it do
      should define_enum_for(:status)
        .with_values(to_do: 'to do', doing: 'doing', done: 'done')
        .backed_by_column_of_type(:string)
    end
  end

  describe 'methods' do
    describe '#to_s' do
      let(:company) { create(:company) }
      let(:maintenance_plan_name) { FFaker::Lorem.word }
      let(:maintenance_plan) { create(:maintenance_plan, name: maintenance_plan_name) }

      before do
        ActsAsTenant.current_tenant = company
      end

      it 'returns the name of the maintenance plan' do
        expect(maintenance_plan.to_s).to eq(maintenance_plan_name)
      end
    end
  end

  describe 'callbacks' do
    describe 'create_maintenances' do
      let!(:company) { create(:company) }

      before do
        ActsAsTenant.current_tenant = company
      end

      let(:client) { create(:client) }
      let(:coolers) { create_list(:cooler, 3, client: client) }
      let(:maintenance_plan) { create(:maintenance_plan, client: client) }
      let(:last_three_maintenances) { coolers.last(3).map(&:maintenances).flatten }

      it 'returns the name of the maintenance plan' do

        ActsAsTenant.with_tenant(company) do
          client
          coolers
          expect { maintenance_plan }.to change(Maintenance, :count).by(3)
          expect(maintenance_plan.maintenances).to include(*last_three_maintenances)
        end
      end
    end
  end
end
