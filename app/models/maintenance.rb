# == Schema Information
#
# Table name: maintenances
#
#  id                    :bigint           not null, primary key
#  date                  :date
#  preventive_maintenace :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  company_id            :integer
#  cooler_id             :integer
#
# Indexes
#
#  index_maintenances_on_cooler_id  (cooler_id)
#
# Foreign Keys
#
#  fk_rails_...  (cooler_id => coolers.id)
#
class Maintenance < ApplicationRecord
  acts_as_tenant :company

  validates :date, :preventive_maintenace, :equipment_hygiene, :frequency, :next_maintence, :irregularity_maintenance, presence: true
end
