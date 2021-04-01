class FriendshipController < ApplicationController

  def index
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @friend_requests = current_user.received_requests
  end

  def result
    if params[:username].blank?
      flash[:danger] = "Please enter a username"
      redirect_to friendship_path 
      return
    end

    if params[:code].blank?
      flash[:danger] = "Please enter user code"
      redirect_to friendship_path 
      return
    end

    @user = User.find_by(username: params[:username], code: params[:code])
  
  end


  def create

    #Disallow the ability to send yourself a friend request
    # For some reason the ids are not the same tpye so it doesn't work if we don't convert both of them "s"
    if current_user.id.to_s == params[:user_id].to_s
      flash[:danger] = "You can't send a request to yourself"
      redirect_to friendship_path
      return

    elsif friend_request_sent?(User.find(params[:user_id]))
    # Disallow the ability to send friend request more than once to same person
      flash[:warning] = "You can't send a request twice"
      redirect_to friendship_path
      return
    
    # Disallow the ability to send friend request to someone who already sent you one
    elsif friend_request_recieved?(User.find(params[:user_id]))
      flash[:warning] = "You already have a request from this person"
      redirect_to friendship_path
      return
    end
  
    @user = User.find(params[:user_id])
    @friendship = current_user.friend_sent.build(sent_to_id: params[:user_id])

    sucess = false
    begin
      sucess = @friendship.save
    rescue => exception
      flash[:danger] = 'Friend Request Failed!'
      redirect_to friendship_path
      return
    end

      flash[:success] = 'Friend Request Sent!'
      redirect_back(fallback_location: root_path)
  end
  

    def accept_friend
      @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
        return unless @friendship # return if no record is found
  
      @friendship.status = true
      if @friendship.save
        flash[:success] = 'Friend Request Accepted!'
        @friendship2 = current_user.friend_sent.build(sent_to_id: params[:user_id], status: true)
        @friendship2.save
      else
        flash[:danger] = 'Friend Request could not be accepted!'
      end
      redirect_back(fallback_location: root_path)
    end
  

    def decline_friend
      @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
      return unless @friendship # return if no record is found
  
      @friendship.destroy
      flash[:success] = 'Friend Request Declined!'
      redirect_back(fallback_location: root_path)
    end

end
