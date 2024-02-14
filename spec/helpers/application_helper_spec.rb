require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#filter_q' do
    it 'combines parameters correctly' do
      params[:q] = { key: 'admin' }
      query = 'responsável técnico'
      result = helper.filter_q(query)
      expect(result.symbolize_keys).to eq({ key: 'admin', role_eq: 'responsável técnico' })
    end

    it 'returns empty if params[:q] is nil' do
      params[:q] = nil
      query = 'some_query'
      resultado = helper.filter_q(query)
      expect(resultado).to eq({ role_eq: 'some_query' })
    end
  end

  describe '#convert_to_id' do
    it 'changes resource to ID formatted correctly' do
      resource = double(id: 123, to_s: 'client')
      resultado = helper.convert_to_id(resource)
      expect(resultado).to eq('client-123')
    end
  end

  describe '#devise_page?' do
    it 'returns true for Devise pages' do
      allow(helper).to receive(:devise_controller?).and_return(true)
      allow(helper).to receive(:controller_name).and_return('sessions')
      resultado = helper.devise_page?
      expect(resultado).to be_truthy
    end

    it 'returns false for pages not related to Devise' do
      allow(helper).to receive(:devise_controller?).and_return(false)
      allow(helper).to receive(:controller_name).and_return('posts')
      resultado = helper.devise_page?
      expect(resultado).to be_falsey
    end
  end
end

