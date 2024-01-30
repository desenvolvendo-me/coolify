class AddEquipamentToMaintenance < ActiveRecord::Migration[7.0]
  def change
    add_reference(:maintenances, :equipment, type: :integer, foreign_key: true)
  end
end
