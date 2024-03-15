module Manager
  class MaintenancePlansController < InternalController
    before_action :set_maintenance_plan, only: %i[show edit update destroy]
    before_action :set_client, only: %i[new edit]

    def index
      @q = MaintenancePlan.ransack(params[:q])
      @maintenance_plans = @q.result(distinct: true)
      @maintenance_plans = @maintenance_plans.order('created_at').page(params[:page])
    end

    def show; end

    def new
      @maintenance_plan = MaintenancePlan.new
    end

    def create
      @maintenance_plan = MaintenancePlan.new(maintenance_plan_params)

      if @maintenance_plan.save
        redirect_to manager_maintenance_plan_path(@maintenance_plan), notice: t('.success')
      else
        render :new,
               status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @maintenance_plan.update(maintenance_plan_params)
        redirect_to manager_maintenance_plan_path(@maintenance_plan), notice: t('.success')
      else
        render :edit,
               status: :unprocessable_entity
      end
    end

    def destroy
      @maintenance_plan.destroy
      redirect_to manager_maintenance_plans_path, notice: t('.success')
    end

    private

    def set_maintenance_plan
      @maintenance_plan = MaintenancePlan.find(params[:id])
    end

    def set_client
      @clients = Client.by_company(current_tenant)
    end

    def maintenance_plan_params
      params.require(:maintenance_plan).permit(:name, :status, :client_id)
    end
  end
end
