class CreateMaintenancePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :maintenance_plans do |t|
      t.string :name
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
