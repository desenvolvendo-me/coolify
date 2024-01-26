class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
end
