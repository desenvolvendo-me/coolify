module Manager
  class ClientsController < InternalController
    before_action :set_client, only: %i[show edit update destroy]

    def index
      @q = Client.ransack(params[:q])
      @clients = @q.result(distinct: true)
      @clients = @clients.order('created_at').page(params[:page]).per(4)
    end

    def show; end

    def new
      @client = Client.new
    end

    def edit; end

    def create
      @client = Client.new(client_params)

      if @client.save
        redirect_to manager_client_path(@client),
                    notice: t('.success')
      else
        render :new,
               status: :unprocessable_entity
      end
    end

    def update
      if @client.update(client_params)
        redirect_to manager_client_path(@client),
                    notice: t('.success')
      else
        render :edit,
               status: :unprocessable_entity
      end
    end

    def destroy
      @client.destroy

      redirect_to manager_clients_path,
                  notice: t('.success')
    end

    private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name)
    end
  end
end
