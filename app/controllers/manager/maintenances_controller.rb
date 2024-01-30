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
      respond_to do |format|
        if @maintenance.save
          format.html do
            redirect_to manager_maintenance_path(@maintenance),
                        notice: t('.create')
          end
        else
          format.html do
            render :new,
                   status: :unprocessable_entity
          end
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @maintenance.update(maintenance_params)
          format.html do
            redirect_to manager_maintenance_path(@maintenance),
                        notice: t('.update')
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
                      notice: t('.destroy')
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
