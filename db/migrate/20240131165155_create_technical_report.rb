class CreateTechnicalReport < ActiveRecord::Migration[7.0]
  def change
    create_table :technical_reports do |t|
      t.timestamps
    end
  end
end
