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
FactoryBot.define do
  factory :equipment do
    tag { %w[S2AR-013 RAR-001 FAR-004 GAR-001 MAR-003A].sample }
  end
end
