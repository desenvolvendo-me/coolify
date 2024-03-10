class AddNewFieldsToRegistrations < ActiveRecord::Migration[7.0]
  def change
    add_column :coolers, :occupants_count, :integer
    add_column :coolers, :equipment_type, :string
    add_column :coolers, :equipment_model, :string
  end
end
