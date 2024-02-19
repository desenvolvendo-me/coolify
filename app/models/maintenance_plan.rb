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
  has_many :maintenances, dependent: :destroy
  enum status: { to_do: 'to do', doing: 'doing', done: 'done' }

  validates :name, presence: true

  def to_s
    name
  end
end
