# == Schema Information
#
# Table name: maintenance_plans
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint           not null
#  company_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_maintenance_plans_on_client_id   (client_id)
#  index_maintenance_plans_on_company_id  (company_id)
#  index_maintenance_plans_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe MaintenancePlan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
