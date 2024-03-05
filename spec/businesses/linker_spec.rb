require 'rails_helper'

RSpec.describe Maintenances::Linker, type: :business do
  describe '#call when a to_do plan exists' do
    let(:company) { create(:company) }
    let(:maintenance) { create(:maintenance) }

    before do
      ActsAsTenant.current_tenant = company
    end

    subject { described_class.call(maintenance) }

    context 'when a to_do plan exists' do
      let!(:to_do_plan) { create(:maintenance_plan, status: :to_do) }

      it 'links the maintenance to the to_do plan' do
        subject
        expect(maintenance.reload.maintenance_plan).to eq(to_do_plan)
      end

      it 'returns true for success?' do
        expect(subject).to be_truthy
      end
    end
  end
end
