require 'rails_helper'

RSpec.describe Maintenances::Linker, type: :business do
  describe '#call when a to_do plan exists' do
    let(:company) { create(:company) }
    let(:maintenance) { build(:maintenance) }

    before do
      ActsAsTenant.current_tenant = company
    end

    subject { described_class.call(maintenance) }

    context 'when a to_do plan exists' do
      let!(:to_do_plan) { create(:maintenance_plan, status: :to_do) }

      it 'links the maintenance to the to_do plan' do
        subject
        expect(maintenance.maintenance_plan).to eq(to_do_plan)
      end

      it 'returns true for success?' do
        expect(subject).to be_truthy
      end
    end

    context 'when the to_do plan does not exist' do
      it 'does not create the maintenance' do
        subject
        expect(maintenance.maintenance_plan).to eq(nil)
      end

      it 'does not returns true for success?' do
        expect(subject).to be_falsey
      end
    end
  end
end
