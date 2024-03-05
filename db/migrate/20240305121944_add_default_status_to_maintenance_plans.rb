class AddDefaultStatusToMaintenancePlans < ActiveRecord::Migration[7.0]
  def change
    change_column_default :maintenance_plans, :status, 'to do'
  end
end
