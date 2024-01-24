# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  cnpj       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { should have_many(:users).dependent(:destroy) }
  end
end
