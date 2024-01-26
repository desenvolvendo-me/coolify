# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
require 'rails_helper'

RSpec.describe Equipment, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:tag) }
  end
end
