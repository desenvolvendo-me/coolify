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
FactoryBot.define do
  factory :maintenance do
    date do
      FFaker::Time.between(Time.zone.local(2023, 11, 1),
                           Time.zone.local(2024, 1, 31))
                  .strftime('%d-%m-%Y')
    end
  end
end
