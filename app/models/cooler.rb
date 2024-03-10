# == Schema Information
#
# Table name: coolers
#
#  id              :bigint           not null, primary key
#  equipment_model :string
#  equipment_type  :string
#  occupants_count :integer
#  tag             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :bigint           not null
#  company_id      :integer
#
# Indexes
#
#  index_coolers_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
class Cooler < ApplicationRecord
  acts_as_tenant :company
  has_many :maintenances, dependent: :destroy
  belongs_to :client

  validates :tag, :occupants_count, :equipment_type, :equipment_model, presence: true

  def to_s
    tag
  end
end
