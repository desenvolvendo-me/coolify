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
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
  end
end
