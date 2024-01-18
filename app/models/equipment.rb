# == Schema Information
#
# Table name: equipment
#
#  id         :bigint           not null, primary key
#  tag        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Equipment < ApplicationRecord
end
