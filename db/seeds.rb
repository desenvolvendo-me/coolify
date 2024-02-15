require 'seed/user_creator'

if Rails.env.development?
  AdminUser.create!(email: 'admin@mail.com',
                    password: 'password', password_confirmation: 'password')

  # Companies
  company_1 = Company.create(cnpj: FFaker::IdentificationBR.cnpj)
  company_2 = Company.create(cnpj: FFaker::IdentificationBR.cnpj)

  # Users
  UserCreator.create_user('Administrador 1', 'admin1@limpar.com', :admin, company_1, avatar_file: 'avatar-2.jpg')
  UserCreator.create_user('Administrador 1', 'admin2@limpar.com', :admin, company_2)
  UserCreator.create_user('Funcionário 1', 'employee1@limpar.com', :employee, company_1, avatar_file: 'avatar-2.jpg')
  UserCreator.create_user('Funcionário 2', 'employee2@limpar.com', :technical_lead, company_1, avatar_file: 'avatar-2.jpg', cft: FFaker::Lorem.characters(10))

  # Clients
  ActsAsTenant.with_tenant(company_1) do
    10.times do
      Client.create(name: FFaker::Company.name, company: company_1)
    end
  end

  ActsAsTenant.with_tenant(company_2) do
    10.times do
      Client.create(name: FFaker::Company.name, company: company_2)
    end
  end


  # Coolers
  ActsAsTenant.with_tenant(company_1) do
    Client.all.each do |client|
      num_coolers = rand(1..3)

      num_coolers.times do
        Cooler.create(tag: FFaker::Vehicle.vin[0..5], company: company_1, client: client)
      end
    end
  end

  ActsAsTenant.with_tenant(company_2) do
    Client.all.each do |client|
      num_coolers = rand(1..3)

      num_coolers.times do
        Cooler.create(tag: FFaker::Vehicle.vin[0..5], company: company_2, client: client)
      end
    end
  end

  # Maintenances
  ActsAsTenant.with_tenant(company_1) do
    Client.all.each do |client|
      client.coolers.each do |cooler|
        random_date = FFaker::Time.between(Date.new(2023, 1, 1), Date.new(2024, 12, 31))
        Maintenance.create(date: random_date, cooler: cooler, company: company_1)
      end
    end
  end
  ActsAsTenant.with_tenant(company_2) do
    Client.all.each do |client|
      client.coolers.each do |cooler|
        random_date = FFaker::Time.between(Date.new(2023, 1, 1), Date.new(2024, 12, 31))
        Maintenance.create(date: random_date, cooler: cooler, company: company_2)
      end
    end
  end

  # Technical Reports / PMOCs
  ActsAsTenant.with_tenant(company_1) do
    TechnicalReport.create(client: Client.all.sample, company: company_1)
  end
end
