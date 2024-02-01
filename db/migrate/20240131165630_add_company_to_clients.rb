class AddCompanyToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :company_id, :integer
  end
end
