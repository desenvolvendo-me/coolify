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
class Client < ApplicationRecord
  acts_as_tenant :company
  has_many :coolers, dependent: :destroy
  has_many :maintenance_plans, dependent: :destroy
  has_many :technical_reports, dependent: :destroy
  validates :name, presence: true

  scope :by_company, ->(company) { where(company_id: company.id) }

  def to_s
    name
  end
end
