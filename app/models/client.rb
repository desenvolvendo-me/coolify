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
#  company_id   :integer
#
class Client < ApplicationRecord
  validates :name, presence: true

  def to_s
    name
  end
end
