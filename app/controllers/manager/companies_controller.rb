module Manager
  class CompaniesController < InternalController
    before_action :set_company, only: %i[show edit update destroy]

    def show; end

    def edit; end

    def update
      if @company.update(company_params)
        redirect_to manager_company_url,
                    notice: t('.success')
      else
        render :edit
      end
    end

    def destroy
      @company.destroy
      redirect_to manager_home_url,
                  notice: t('.success')
    end

    private

    def set_company
      @company = current_user.company
    end

    def company_params
      params.require(:company).permit(
        :cnpj
      )
    end
  end
end
