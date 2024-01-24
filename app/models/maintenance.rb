# == Schema Information
#
# Table name: maintenances
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
class Maintenance < ApplicationRecord
  acts_as_tenant :company

  validates :date, presence: true
end
