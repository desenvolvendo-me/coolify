# == Schema Information
#
# Table name: maintenance_plans
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_maintenance_plans_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class MaintenancePlan < ApplicationRecord
  acts_as_tenant :company
  has_many :maintenances, dependent: :destroy
  enum status: { to_do: 'to do', doing: 'doing', done: 'done' }

  validates :name, presence: true

  def to_s
    name
  end
end
