class AddCompanyToEntities < ActiveRecord::Migration[7.0]
  def change
    add_column :maintenances, :company_id, :integer
    add_column :equipment, :company_id, :integer
    add_column :clients, :company_id, :integer
  end
end
