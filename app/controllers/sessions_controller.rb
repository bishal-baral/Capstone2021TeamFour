# frozen_string_literal: true

# The sessions controller is purely responsible for logging users in and out
class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :require_logged_out, only: %i[new create]

  def new() end

  # Log in action, needs an email and password in params
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email password combo'
      render 'new'
    end
  end

  # Log out action
  def destroy
    log_out
    redirect_to root_path
  end

  private

  # Redirect logged in users away from the login page
  def require_logged_out
    return unless logged_in?

    redirect_to profile_path
  end
end
