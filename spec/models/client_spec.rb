# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'association' do
    it { should belong_to(:company) }
    it { should have_many(:coolers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#to_s' do
    let(:client) { create(:client) }

    it 'return the client name' do
      expect(client.to_s).to eq(client.name)
    end
  end
end
