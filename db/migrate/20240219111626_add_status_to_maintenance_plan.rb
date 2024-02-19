class AddStatusToMaintenancePlan < ActiveRecord::Migration[7.0]
  def change
    add_column :maintenance_plans, :status, :string
  end
end
