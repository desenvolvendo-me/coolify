module Manager
  module Coolers
    class MaintenancesController < InternalController
      before_action :set_cooler
      before_action :set_maintenance, only: %i[show edit update destroy]

      def index
        @q = @cooler.maintenances.ransack(params[:q])
        @maintenances = @q.result(distinct: true)
        @maintenances = @maintenances.order('date DESC').page(params[:page])
      end

      def show; end

      def new
        @maintenance = @cooler.maintenances.build
      end

      def create
        @maintenance = @cooler.maintenances.build(maintenance_params)
        respond_to do |format|
          if @maintenance.save
            format.html do
              redirect_to manager_cooler_maintenance_path(@cooler, @maintenance),
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
              redirect_to manager_cooler_maintenance_path(@cooler, @maintenance),
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
            redirect_to manager_cooler_maintenances_path(@cooler),
                        notice: t('.destroy')
          end
        end
      end

      private

      def set_cooler
        @cooler = Cooler.find(params[:cooler_id])
      end

      def set_maintenance
        @maintenance = Maintenance.find(params[:id])
      end

      def maintenance_params
        params.require(:maintenance).permit(:date, :cooler_id)
      end
    end
  end
end
