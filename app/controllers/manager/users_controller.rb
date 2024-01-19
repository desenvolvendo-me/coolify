module Manager
  class UsersController < InternalController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @q = User.where.not(id: current_user).ransack(params[:q])
      @users = @q.result(distinct: true)
      @users = @users.order('created_at').page(params[:page]).per(4)
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to manager_user_path(@user),
                    notice: t('.create')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to manager_user_path(@user),
                    notice: 'Usuário atualizado com sucesso.'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to manager_users_url, notice: t('.destroy')
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def check_admin
      redirect_to(root_url, notice: t('.check_admin')) unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :role)
    end
  end
end
