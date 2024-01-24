require 'rails_helper'

RSpec.describe Manager::EquipmentsController, type: :controller do
  let(:equipment) { create(:equipment) }
  let(:valid_attributes) { { tag: '001' } }
  let(:invalid_attributes) { { tag: '' } }

  describe 'GET #index' do
    it 'assigns all equipments as @equipments' do
      get :index
      expect(assigns(:equipments)).to eq([equipment])
    end

    it 'excludes non-matching results' do
      create(:equipment, tag: '987')

      get :index,
          params: {
            q: {
              tag_cont:
                '002'
            }
          }

      expect(assigns(:equipments)).to be_empty
    end
  end

  describe 'GET #show' do
    it 'assigns the requested equipment as @equipment' do
      get :show, params: { id: equipment.id }
      expect(assigns(:equipment)).to eq(equipment)
    end
  end

  describe 'GET #new' do
    it 'assigns a new equipment as @equipment' do
      get :new
      expect(assigns(:equipment)).to be_a_new(Equipment)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested equipment as @equipment' do
      get :edit, params: { id: equipment.id }
      expect(assigns(:equipment)).to eq(equipment)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Equipment' do
        expect do
          post :create, params: { equipment: valid_attributes }
        end.to change(Equipment, :count).by(1)
      end

      it 'redirects to the created equipment' do
        post :create, params: { equipment: valid_attributes }
        expect(response).to redirect_to(manager_equipment_path(Equipment.last))
      end
    end

    context 'with invalid params' do
      it 're-renders the "new" template' do
        post :create, params: { equipment: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested equipment' do
        put :update, params: { id: equipment.id, equipment: valid_attributes }
        equipment.reload
        expect(equipment.tag).to eq('001')
      end

      it 'redirects to the equipment' do
        put :update, params: { id: equipment.id, equipment: valid_attributes }
        expect(response).to redirect_to(manager_equipment_path(equipment))
      end
    end

    context 'with invalid params' do
      it 're-renders the "edit" template' do
        put :update, params: { id: equipment.id, equipment: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested equipment' do
      equipment = create(:equipment)
      expect do
        delete :destroy, params: { id: equipment.id }
      end.to change(Equipment, :count).by(-1)
    end

    it 'redirects to the equipments list' do
      delete :destroy, params: { id: equipment.id }
      expect(response).to redirect_to(manager_equipments_path)
    end
  end
end
