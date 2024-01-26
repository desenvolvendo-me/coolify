# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
class Equipment < ApplicationRecord
  acts_as_tenant :company

  validates :tag, presence: true
end
