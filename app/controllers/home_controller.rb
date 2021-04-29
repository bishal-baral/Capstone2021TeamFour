class HomeController < ApplicationController
  before_action :set_user, only: %i[show]
  skip_before_action :require_login
  before_action :require_logged_out

  # Welcome page action. Nothing to do but redirect if they're logged in
  def index() end

  private

  def require_logged_out
    return unless logged_in?

    redirect_to profile_path
  end
end
