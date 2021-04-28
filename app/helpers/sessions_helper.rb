module SessionsHelper
  # Log in a user by storing their id
  def log_in(user)
    session[:user_id] = user.id
  end

  # Get the current user
  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Check if some user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Log out the current user
  def log_out
    reset_session
    @current_user = nil
  end
end
