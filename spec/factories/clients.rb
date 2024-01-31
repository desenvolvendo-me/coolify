# == Schema Information
#
# Table name: clients
#
#  id           :bigint           not null, primary key
#  bairro       :string
#  cep          :string
#  cidade       :string
#  cnpj         :string
#  email        :string
#  endereco     :string
#  name         :string
#  razao_social :string
#  telefone     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :client do
    name { FFaker::Name.name }
  end
end
