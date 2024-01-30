class CreateCoolers < ActiveRecord::Migration[7.0]
  def change
    create_table :coolers do |t|
      t.string :tag

      t.timestamps
    end
  end
end
