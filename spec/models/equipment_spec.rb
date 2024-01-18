require 'rails_helper'

RSpec.describe Equipment, type: :model do
  it 'is valid with valid attributes' do
    equipment = build(:equipment, tag: '002')
    expect(equipment).to be_valid
  end
end
