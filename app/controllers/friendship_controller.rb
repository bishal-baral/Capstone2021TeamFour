class FriendshipController < ApplicationController
  def index
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
  end

  def result
    @user = User.find_by(username: params[:username], code: params[:code])
    respond_to do |format|
      format.js { render layout: false }
    end
  end

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
