# == Schema Information
#
# Table name: maintenances
#
#  id           :bigint           not null, primary key
#  date         :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#  equipment_id :integer
#
# Indexes
#
#  index_maintenances_on_equipment_id  (equipment_id)
#
# Foreign Keys
#
#  fk_rails_...  (equipment_id => equipment.id)
#
FactoryBot.define do
  factory :maintenance do
    date do
      FFaker::Time.between(Time.zone.local(2023, 11, 1),
                           Time.zone.local(2024, 1, 31))
                  .strftime('%d-%m-%Y')
    end
  end
end
