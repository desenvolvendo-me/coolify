class RenameEquipmentToCoolers < ActiveRecord::Migration[7.0]
  def change
    rename_table :equipment, :coolers
  end
end
