require 'rails_helper'

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
