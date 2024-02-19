# == Schema Information
#
# Table name: maintenance_plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MaintenancePlan < ApplicationRecord
  validates :name, presence: true

  enum status: { to_do: 'to do', doing: 'doing', done: 'done' }

  def to_s
    name
  end
end
