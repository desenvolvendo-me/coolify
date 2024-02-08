require 'rails_helper'
# class CftValidatable
#   include ActiveModel::Model
#
#   attr_accessor :cft, :role
#
#   validates :cft, cft: true
# end
#
# RSpec.describe CftValidator do
#   context 'when the user is a technical lead and does not inform his cft' do
#     let(:technical_lead_user) { CftValidatable.new(cft: nil, role: 'technical_lead') }
#
#     it 'is invalid' do
#       expect(technical_lead_user).not_to be_valid
#     end
#   end
#
#   context 'when the user is not a technical lead and does not inform his cft' do
#     let(:admin_user) { CftValidatable.new(cft: nil, role: 'admin') }
#     let(:employee_user) { CftValidatable.new(cft: nil, role: 'employee') }
#
#     it 'id valid' do
#       expect(admin_user).to be_valid
#       expect(employee_user).to be_valid
#     end
#   end
#
#   context 'when the user informs his cft' do
#     let(:technical_lead_user) { CftValidatable.new(cft: FFaker::Lorem.characters(10), role: 'technical_lead') }
#     let(:admin_user) { CftValidatable.new(cft: FFaker::Lorem.characters(10), role: 'admin') }
#     let(:employee_user) { CftValidatable.new(cft: FFaker::Lorem.characters(10), role: 'employee') }
#
#     it 'is valid' do
#       expect(technical_lead_user).to be_valid
#       expect(admin_user).to be_valid
#       expect(employee_user).to be_valid
#     end
#   end
#
# end

RSpec.describe CftValidator do
  subject(:user) do
    build(:user, cft: cft, role: role)
  end

  shared_examples 'valid user' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  shared_examples 'invalid user' do
    it 'is invalid' do
      expect(user).not_to be_valid
    end
  end

  context 'when the user is a technical lead' do
    let(:role) { 'technical_lead' }

    context 'and does not inform their cft' do
      let(:cft) { nil }
      it_behaves_like 'invalid user'
    end

    context 'and informs their cft' do
      let(:cft) { FFaker::Lorem.characters(10) }
      it_behaves_like 'valid user'
    end
  end

  context 'when the user is not a technical lead' do
    context 'and does not inform their cft' do
      let(:role) { 'admin' }
      let(:cft) { nil }
      it_behaves_like 'valid user'
    end

    context 'and informs their cft' do
      let(:role) { 'employee' }
      let(:cft) { FFaker::Lorem.characters(10) }
      it_behaves_like 'valid user'
    end
  end
end
