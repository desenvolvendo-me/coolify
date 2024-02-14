# == Schema Information
#
# Table name: maintenance_plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MaintenancePlan < ApplicationRecord

  validates :name, presence: true

  def to_s
    name
  end
end
