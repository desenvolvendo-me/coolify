# == Schema Information
#
# Table name: maintenances
#
#  id                  :bigint           not null, primary key
#  date                :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_id          :integer
#  cooler_id           :integer
#  maintenance_plan_id :bigint
#
# Indexes
#
#  index_maintenances_on_cooler_id            (cooler_id)
#  index_maintenances_on_maintenance_plan_id  (maintenance_plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (cooler_id => coolers.id)
#  fk_rails_...  (maintenance_plan_id => maintenance_plans.id)
#
require 'rails_helper'

RSpec.describe Maintenance, type: :model do
  describe 'association' do
    it { should belong_to(:company) }
    it { should belong_to(:cooler) }
    it { should belong_to(:maintenance_plan).optional(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:cooler) }
  end

  describe 'callbacks' do
    let(:company) { create(:company) }
    let(:maintenance) { build(:maintenance) }

    before do
      ActsAsTenant.current_tenant = company
    end

    context 'when attempting to save a new Maintenance record without a "to_do" maintenance plan' do
      it 'does not save the Maintenance record before linking it' do
        expect { maintenance.save }.not_to change(Maintenance, :count)
      end
    end

    context 'when attempting to save a new Maintenance record with a "to_do" maintenance plan' do
      let!(:to_do_plan) { create(:maintenance_plan, status: 'to do') }

      it 'saves the Maintenance record after successfully linking it' do
        expect { maintenance.save }.to change(Maintenance, :count).by(1)
      end
    end
  end
end
