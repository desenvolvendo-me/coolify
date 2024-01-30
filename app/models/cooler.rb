# == Schema Information
#
# Table name: coolers
#
#  id         :bigint           not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
class Cooler < ApplicationRecord
  acts_as_tenant :company
  has_many :maintenances, dependent: :destroy

  validates :tag, presence: true

  def to_s
    tag
  end
end
