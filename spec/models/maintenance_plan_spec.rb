# == Schema Information
#
# Table name: maintenance_plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe MaintenancePlan, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
