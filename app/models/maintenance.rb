# == Schema Information
#
# Table name: maintenances
#
#  id                  :bigint           not null, primary key
#  date                :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  company_id          :integer
#  cooler_id           :integer
#  maintenance_plan_id :bigint
#
# Indexes
#
#  index_maintenances_on_cooler_id            (cooler_id)
#  index_maintenances_on_maintenance_plan_id  (maintenance_plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (cooler_id => coolers.id)
#  fk_rails_...  (maintenance_plan_id => maintenance_plans.id)
#
class Maintenance < ApplicationRecord
  acts_as_tenant :company
  belongs_to :cooler
  belongs_to :maintenance_plan, optional: true

  validates :date, :cooler, presence: true

  before_create :link_to_do_plan

  private

  def link_to_do_plan
    linker = Maintenances::Linker.new(self)
    linker.call

    return if linker.success?

    errors.add(:base, :no_maintenance_plan)
    throw(:abort)
  end
end
