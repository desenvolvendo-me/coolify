class AddClientToMaintenancePlans < ActiveRecord::Migration[7.0]
  def change
    add_reference :maintenance_plans, :client, null: false, foreign_key: true
  end
end
