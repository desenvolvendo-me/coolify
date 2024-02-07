module Manager
  module Clients
    class CoolersController < InternalController
      before_action :set_client
      before_action :set_cooler, only: %i[show edit update destroy]

      def index
        @q = @client.coolers.ransack(params[:q])
        @coolers = @q.result(distinct: true)
        @coolers = @coolers.page(params[:page])
      end

      def show; end

      def new
        @cooler = @client.coolers.build
      end

      def create
        @cooler = @client.coolers.build(cooler_params)
        respond_to do |format|
          if @cooler.save
            format.html do
              redirect_to manager_client_cooler_path(@client, @cooler),
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
          if @cooler.update(cooler_params)
            format.html do
              redirect_to manager_client_cooler_path(@client, @cooler),
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
        @cooler.destroy
        respond_to do |format|
          format.html do
            redirect_to manager_client_coolers_path(@client),
                        notice: t('.destroy')
          end
        end
      end

      private

      def set_client
        @client = Client.find(params[:client_id])
      end

      def set_cooler
        @cooler = Cooler.find(params[:id])
      end

      def cooler_params
        params.require(:cooler).permit(:tag, :client_id)
      end
    end
  end
end
