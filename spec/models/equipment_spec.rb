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
  it 'is valid with valid attributes' do
    equipment = build(:equipment, tag: '002')
    expect(equipment).to be_valid
  end
end
