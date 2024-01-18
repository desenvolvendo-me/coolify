class InternalController < ApplicationController
  layout 'internal'

  before_action :authenticate_user!
end
