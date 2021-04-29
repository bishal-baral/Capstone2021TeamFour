# frozen_string_literal: true

# The users controller is purely responsible for logging users in and out
class UsersController < ApplicationController
  include UsersHelper
  skip_before_action :require_login, only: %i[new create]
  before_action :require_logged_out, only: %i[new create]

  # GET signup action. set up an empty user for signup
  def new
    @user = User.new
  end

  # POST signup action. Create user from params if valid
  def create
    @user = User.new(user_params)
    gen_code(@user)

    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'Caught you on the flippity flip'
      render 'profile'
    else
      render 'new'
    end
  end

  def show
    @new_event = Event.new
    @friends = current_user.friends
    @new_review = Review.new
    @user = current_user
    temp_revs = []
    @user.friends.each do |friend|
      temp_revs += friend.reviews
    end
    @reviews = temp_revs.sort_by{ |r| r.post_date }.reverse

    respond_to do |format|
      format.html 
      format.js {render layout: false}
    end

  end

  # POST search action. Same thing as show but filters the reviews
  def search
    @user = current_user
    temp_revs = []
    if !params[:search_terms].nil?
      tags = tags_from_string(params[:search_terms])
      temp_revs = filter_reviews(temp_revs, tags)
    end
    @user.friends.each do |friend|
      temp_revs += friend.reviews
    end
    tags = tags_from_string(params[:search_terms])
    temp_revs = filter_reviews(temp_revs, tags)
    @reviews = temp_revs.sort_by(&:post_date).reverse
  end

  # GET profile action. Gets the users own reviews and sets up tag creation
  def profile
    @reviews = current_user.reviews
    @tag = Tag.new
  end

  # POST avatar action. Allows the user to upload a (new) avatar
  def avatar
    @user = current_user
    @user.avatar.attach(params[:avatar][:avatar])
    respond_to do |format|
      format.js
    end
  end

  # GET friend_profile action. Shows user a requested friend's profile
  def friend_profile
    @user = User.all.find_by(id: params[:user_id])

    redirect_to profile_path if @user.friends.where(id: current_user.id).empty?

    @reviews = Review.all
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password,
                                 :password_confirmation)
  end

  def require_logged_out
    return unless logged_in?

    redirect_to profile_path
  end
end
