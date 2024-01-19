class EquipmentsController < ApplicationController
  before_action :set_equipment, only: %i[show edit update destroy]

  def index
    @q = Equipment.ransack(params[:q])
    @equipments = @q.result(distinct: true)
    @equipments = @equipments.order('created_at').page(params[:page]).per(4)
  end

  def show; end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)

    if @equipment.save
      redirect_to @equipment, notice: t('.create')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @equipment.update(equipment_params)
      redirect_to @equipment, notice: t('.update')
    else
      render :edit
    end
  end

  def destroy
    @equipment.destroy
    redirect_to equipments_url, notice: t('.destroy')
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:tag)
  end
end
