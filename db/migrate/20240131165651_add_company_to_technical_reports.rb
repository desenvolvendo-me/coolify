class AddCompanyToTechnicalReports < ActiveRecord::Migration[7.0]
  def change
    add_column :technical_reports, :company_id, :integer
  end
end
