class AddPreventiveMaintenanceToMaintenances < ActiveRecord::Migration[7.0]
  def change
    add_column :maintenances, :preventive_maintenace, :string
  end
end
