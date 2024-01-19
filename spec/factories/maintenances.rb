# spec/factories/maintenances.rb
FactoryBot.define do
  factory :maintenance do
    date do
      FFaker::Time.between(Time.zone.local(2023, 11, 1),
                           Time.zone.local(2024, 1, 31))
                  .strftime('%d-%m-%Y')
    end
  end
end
