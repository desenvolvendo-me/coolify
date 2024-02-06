module Manager
  class CoolersController < InternalController
    before_action :set_cooler, only: %i[show edit update destroy]

    def index
      @q = Cooler.ransack(params[:q])
      @coolers = @q.result(distinct: true)
      @coolers = @coolers.order('created_at').page(params[:page])
    end

    def show; end

    def new
      @cooler = Cooler.new
    end

    def create
      @cooler = Cooler.new(cooler_params)

      if @cooler.save
        redirect_to manager_cooler_path(@cooler), notice: t('.create')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @cooler.update(cooler_params)
        redirect_to manager_cooler_path(@cooler), notice: t('.update')
      else
        render :edit
      end
    end

    def destroy
      @cooler.destroy
      redirect_to manager_coolers_path, notice: t('.destroy')
    end

    private

    def set_cooler
      @cooler = Cooler.find(params[:id])
    end

    def cooler_params
      params.require(:cooler).permit(:tag, :client_id)
    end
  end
end
