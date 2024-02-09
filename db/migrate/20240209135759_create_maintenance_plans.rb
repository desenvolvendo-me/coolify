class CreateMaintenancePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :maintenance_plans do |t|
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
