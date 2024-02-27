# == Schema Information
#
# Table name: equipment
#
#  id               :bigint           not null, primary key
#  equipment_model  :string
#  equipment_type   :string
#  number_occupants :integer
#  tag              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :integer
#
class Equipment < ApplicationRecord
  acts_as_tenant :company

  validates :tag, :number_occupants, :equipment_type, :equipment_model, presence: true
end
