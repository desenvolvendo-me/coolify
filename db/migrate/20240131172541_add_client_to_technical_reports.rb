class AddClientToTechnicalReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :technical_reports, :client, null: false, foreign_key: true
  end
end
