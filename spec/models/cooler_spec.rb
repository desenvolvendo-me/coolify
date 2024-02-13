# == Schema Information
#
# Table name: cooler
#
#  id         :bigint           not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
require 'rails_helper'

RSpec.describe Cooler, type: :model do
  describe 'association' do
    it { should belong_to(:company) }
    it { should belong_to(:client) }
    it { should have_many(:maintenances) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:tag) }
  end
end
