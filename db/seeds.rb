require 'seed/user_creator'

if Rails.env.development?
  AdminUser.create!(email: 'admin@mail.com',
                    password: 'password', password_confirmation: 'password')

  # Companies
  company_1 = Company.create(cnpj: FFaker::IdentificationBR.cnpj)
  company_2 = Company.create(cnpj: FFaker::IdentificationBR.cnpj)

  # Users
  UserCreator.create_user('Administrador 1', 'admin1@limpar.com', :admin, company_1, 'avatar-1.jpg')
  UserCreator.create_user('Administrador 1', 'admin2@limpar.com', :admin, company_2)
  UserCreator.create_user('Funcionário 1', 'employee1@limpar.com', :employee, company_1, 'avatar-2.jpg')

  # Equipments
  10.times do |i|
    tag = FFaker::Vehicle.vin[0..5]
    company = (i <= 5) ? company_1 : company_2

    Equipment.create(tag: tag, company: company)
  end

  # Maintenances
  10.times do |i|
    random_date = FFaker::Time.between(Date.new(2023, 1, 1), Date.new(2024, 12, 31))

    company = (i <= 5) ? company_1 : company_2

    Maintenance.create(date: random_date, company: company)
  end

  # Clients
  5.times do
    Client.create(name: FFaker::Company.name)
  end
end
