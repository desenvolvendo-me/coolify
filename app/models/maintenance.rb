# == Schema Information
#
# Table name: maintenances
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Maintenance < ApplicationRecord
end
