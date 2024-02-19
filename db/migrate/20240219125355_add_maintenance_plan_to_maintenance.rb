class AddMaintenancePlanToMaintenance < ActiveRecord::Migration[7.0]
  def change
    add_reference :maintenances, :maintenance_plan, null: true, foreign_key: true
  end
end
