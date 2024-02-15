class AddCompanyToTechnicalReports < ActiveRecord::Migration[7.0]
  def up
    add_column :technical_reports, :company_id, :integer
    add_index  :technical_reports, :company_id
  end
end
