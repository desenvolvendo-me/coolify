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
class Client < ApplicationRecord
  validates :name, :endereco, :bairro, :telefone, :cnpj, :cep, :cidade, :email, presence: true
  validates :cnpj, length: { is: 14 }, format: { with: /\A\d{14}\z/, message: 'must be 14 digits' }
  validates :cep, length: { is: 8 }, format: { with: /\A\d{8}\z/, message: 'must be 8 digits' }
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'invalid email format' }

  def to_s
    name
  end
end
