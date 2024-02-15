class AddClientToCoolers < ActiveRecord::Migration[7.0]
  def change
    add_reference :coolers, :client, null: false, foreign_key: true
  end
end
