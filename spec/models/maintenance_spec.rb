# == Schema Information
#
# Table name: maintenances
#
#  id           :bigint           not null, primary key
#  date         :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#  equipment_id :integer
#
# Indexes
#
#  index_maintenances_on_equipment_id  (equipment_id)
#
# Foreign Keys
#
#  fk_rails_...  (equipment_id => equipment.id)
#
require 'rails_helper'

RSpec.describe Maintenance, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
  end
end
