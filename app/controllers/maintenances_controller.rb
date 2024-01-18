class MaintenancesController < ApplicationController
  before_action :set_maintenance, only: %i[show edit update destroy]

  def index
    @q = Maintenance.ransack(params[:q])
    @maintenances = @q.result(distinct: true)
    @maintenances = @maintenances.order('date DESC').page(params[:page]).per(4)
  end

  def show; end

  def new
    @maintenance = Maintenance.new
  end

  def edit; end

  def create
    @maintenance = Maintenance.new(maintenance_params)
    respond_to do |format|
      if @maintenance.save
        format.html do
          redirect_to maintenance_path(@maintenance),
                      notice: 'Manutenção cadastrada com sucesso'
        end
      else
        format.html do
          render :new,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @maintenance.update(maintenance_params)
        format.html do
          redirect_to maintenance_path(@maintenance),
                      notice: 'Manutenção atualizada com sucesso'
        end
      else
        format.html do
          render :edit,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @maintenance.destroy
    respond_to do |format|
      format.html do
        redirect_to maintenances_path,
                    notice: 'Manutenção apagada com sucesso'
      end
    end
  end

  private

  def set_maintenance
    @maintenance = Maintenance.find(params[:id])
  end

  def maintenance_params
    params.require(:maintenance).permit(:date)
  end
end
