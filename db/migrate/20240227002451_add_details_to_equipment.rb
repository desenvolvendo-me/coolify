class AddDetailsToEquipment < ActiveRecord::Migration[7.0]
  def change
    add_column :equipment, :number_occupants, :integer
    add_column :equipment, :equipment_type, :string
    add_column :equipment, :equipment_model, :string
  end
end
