class AddCoolerToMaintenance < ActiveRecord::Migration[7.0]
  def change
    add_reference(:maintenances, :cooler, type: :integer, foreign_key: true)
  end
end
