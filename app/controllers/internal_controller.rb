class InternalController < ApplicationController
  include Pundit::Authorization
  before_action :authenticate_user!

  layout 'internal'

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    message = t("#{policy_name}.#{exception.query}")
    notice = t('manager.users.check_admin', action: message, current_user: current_user)
    redirect_to(request.referrer || root_path, notice: notice)
  end
end
