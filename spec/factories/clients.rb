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
FactoryBot.define do
  factory :client do
    name { FFaker::Name.name }
    company
  end
end
