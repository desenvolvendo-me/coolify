module Manager
  class MaintenancePlansController < InternalController
    before_action :set_maintenance_plan, only: %i[show edit update destroy]

    def index
      @maintenance_plan = MaintenancePlan.all
    end

    def show; end

    def new
      @maintenance_plan = MaintenancePlan.new
    end

    def create
      @maintenance_plan = MaintenancePlan.new(maintenance_plan_params)

      if @maintenance_plan.save
        redirect_to manager_maintenance_plan_path(@maintenance_plan), notice: 'Successfully registered maintenance plan.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @maintenance_plan.update(maintenance_plan_params)
        redirect_to manager_maintenance_plan_path(@maintenance_plan), notice: 'Successfully updated maintenance plan.'
      else
        render :edit
      end
    end

    def destroy
      @maintenance_plan.destroy
      redirect_to manager_maintenance_plans_path, notice: 'Successfully deleted maintenance plan.'
    end

    private

    def set_maintenance_plan
      @maintenance_plan = MaintenancePlan.find(params[:id])
    end

    def maintenance_plan_params
      params.require(:maintenance_plan).permit(:name)
    end
  end
end
