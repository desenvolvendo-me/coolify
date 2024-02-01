# == Schema Information
#
# Table name: technical_reports
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint           not null
#  company_id :integer
#
# Indexes
#
#  index_technical_reports_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
class TechnicalReport < ApplicationRecord
  belongs_to :client
  acts_as_tenant :company
end
