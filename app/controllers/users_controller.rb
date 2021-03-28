class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # Generate a code that's unique when combined with username
    friend_code = rand(1000...9999)
    while User.where(username: @user.username, code: friend_code).count > 0
      friend_code = rand(1000.9999)
    end
    @user.code = friend_code

    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Caught you on the flippity flip"
      redirect_to @user
    else
      render 'new'
    end

  end

  def show
    @user = current_user
    temp_revs = []
    @user.friends.each do |friend|
      temp_revs += friend.reviews
    end
    @reviews = temp_revs.sort_by{ |r| r.post_date }.reverse
  end

  def profile
    
    @reviews = Review.all
  end
  

  private

    def user_params
      params.require(:user).permit(:email, :username, :password,
                                               :password_confirmation)
    end

end
