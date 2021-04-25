class HomeController < ApplicationController
  before_action :set_user, only: %i[show]
  skip_before_action :require_login
  before_action :require_logged_out

  def index
  end
  private
  def require_logged_out
    if logged_in?
      redirect_to profile_path
    end
  end
end
