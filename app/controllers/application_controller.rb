class ApplicationController < ActionController::Base
  include SessionsHelper
  include FriendshipHelper

  before_action :require_login

  private 
    def require_login
      unless logged_in?
        redirect_to root_path
      end
    end
end
