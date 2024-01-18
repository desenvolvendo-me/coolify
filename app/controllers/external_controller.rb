class ExternalController < ApplicationController
  layout 'external'

  before_action :check_login

  private

  def check_login
    redirect_to(manager_home_path) if current_user
  end
end
