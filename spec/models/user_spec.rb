# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  cft                    :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    context 'for technical leads' do
      let(:technical_lead) { build(:user, role: 'technical_lead', cft: nil) }

      it 'requires CFT for technical leads' do
        technical_lead.valid?
        expect(technical_lead.errors[:cft]).to include(I18n.t('activerecord.errors.models.user.attributes.cft.blank'))
      end
    end

    context 'for other roles' do
      let(:admin) { build(:user, role: 'admin', cft: nil) }

      it 'does not require CFT for other roles' do
        expect(admin).to be_valid
      end
    end
  end
end
