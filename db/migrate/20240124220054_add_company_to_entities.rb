class AddCompanyToEntities < ActiveRecord::Migration[7.0]
  def change
    add_column :maintenances, :company_id, :integer
    add_column :coolers, :company_id, :integer
    add_column :clients, :company_id, :integer
  end
end
