# == Schema Information
#
# Table name: maintenance_plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :maintenance_plan do
    name { "MyString" }
  end
end
