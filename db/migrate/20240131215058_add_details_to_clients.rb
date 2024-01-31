class AddDetailsToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :razao_social, :string
    add_column :clients, :endereco, :string
    add_column :clients, :bairro, :string
    add_column :clients, :telefone, :string
    add_column :clients, :cnpj, :string
    add_column :clients, :cep, :string
    add_column :clients, :cidade, :string
    add_column :clients, :email, :string
  end
end
