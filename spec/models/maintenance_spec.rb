# == Schema Information
#
# Table name: maintenances
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#  cooler_id  :integer
#
# Indexes
#
#  index_maintenances_on_cooler_id  (cooler_id)
#
# Foreign Keys
#
#  fk_rails_...  (cooler_id => coolers.id)
#
require 'rails_helper'

RSpec.describe Maintenance, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
  end
end
