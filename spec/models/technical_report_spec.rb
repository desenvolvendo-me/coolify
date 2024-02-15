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
#  index_technical_reports_on_client_id   (client_id)
#  index_technical_reports_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
require 'rails_helper'

RSpec.describe TechnicalReport, type: :model do
  describe 'association' do
    it { should belong_to(:company) }
    it { should belong_to(:client) }
  end
end
