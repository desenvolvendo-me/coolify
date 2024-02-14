class AddClientToEquipament < ActiveRecord::Migration[7.0]
  def change
    add_reference(:coolers, :client, type: :integer, foreign_key: true)
  end
end
