# frozen_string_literal: true

# The friendship controller manages users' friend page and friend requests
class FriendshipController < ApplicationController
  # GET Friendship action. The main page for friendship
  def index
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
  end

  # GET Result action. Renders search result for potential friends
  def result
    @user = User.find_by(username: params[:username], code: params[:code])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  # POST Friendship action. Allows users to send valid friend requests
  def create
    message = can_friend_check current_user.id, params[:user_id].to_i
    unless message.nil?
      flash[:warning] = message
      redirect_to friendship_path
      return
    end

    @friendship = current_user.friend_sent.build(sent_to_id: params[:user_id])

    Notification.create(recipient: User.find(params[:user_id]),
                        actor: current_user,
                        action: 'sent',
                        notifiable: @friendship)

    flash[:success] = 'Friend request sent!'
    redirect_to friendship_path
  end

  # PUT Friendship action. Allows users accept friend requests
  def accept_friend
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    if !@friendship.nil?
      @friendship.status = true
      if @friendship.save
        flash[:success] = 'Friend request accepted!'
        @friendship2 = current_user.friend_sent.build(sent_to_id: params[:user_id], status: true)
        @friendship2.save
      end
    else
      flash[:warning] = 'Friend request does not exist'
    end
    redirect_to friendship_path
  end

  # DESTROY Friendship action. Allows users decline friend requests
  def decline_friend
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    if !@friendship.nil?
      @friendship.destroy
      flash[:success] = 'Friend request declined!'
    else
      flash[:warning] = 'Friend request does not exist'
    end
    redirect_to friendship_path
  end
end
