module Manager
  class MaintenancesController < InternalController
    before_action :set_maintenance, only: %i[show edit update destroy]

    def index
      @q = Maintenance.ransack(params[:q])
      @maintenances = @q.result(distinct: true)
      @maintenances = @maintenances.order('date DESC').page(params[:page])
    end

    def show; end

    def new
      @maintenance = Maintenance.new
    end

    def create
      @maintenance = Maintenance.new(maintenance_params)
      MaintenancePlans::Linker.call(@maintenance)

      if @maintenance.maintenance_plan
        if @maintenance.save
          redirect_to manager_maintenance_path(@maintenance), notice: t('.success')
        else
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to new_manager_maintenance_path, notice: t('.no_maintenance_plan')
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @maintenance.update(maintenance_params)
          format.html do
            redirect_to manager_maintenance_path(@maintenance),
                        notice: t('.success')
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
          redirect_to manager_maintenances_path,
                      notice: t('.success')
        end
      end
    end

    private

    def set_maintenance
      @maintenance = Maintenance.find(params[:id])
    end

    def maintenance_params
      params.require(:maintenance).permit(:date, :cooler_id)
    end
  end
end
