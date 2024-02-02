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
        @user.send_reset_password_instructions
        redirect_to manager_user_path(@user),
                    notice: t('.create')
      else
        render :new,
               status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if user_params[:password].blank? && user_params[:password_confirmation].blank?
        @user.update_without_password(user_params)
      else
        @user.update_with_password(user_params)
      end

      if @user.valid?
        redirect_to manager_user_path(@user),
                    notice: t('.update')
      else
        render :edit,
               status: :unprocessable_entity
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
      params.require(:user).permit(:name, :avatar, :email, :password,
                                   :password_confirmation, :role)
    end
  end
end
