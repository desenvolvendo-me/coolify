# == Schema Information
#
# Table name: maintenances
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Maintenance, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
  end
end
