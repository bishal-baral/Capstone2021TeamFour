class EventsController < ApplicationController

  def show
    @event = Event.where(user_id: current_user.id )
    #Map to hold event => Invitee array
    event_invitees_map = {}
    #Map to hold event => User array
    @users = {}

    ## The following part could probably be improved by making the database better
    #Iterate through the events
    @event.each do |event|
      # Find all the invites of the particular event
      invitees = Invitee.where(event_id: event.id)
      # Add the invitees aray to the Map
      event_invitees_map[event] = invitees
    end

    # Iterate through the events_invitees_map to get the Individual invitees
    event_invitees_map.each do |event, invitees|
      # Array to hold users for the specific events.
      users_array = []
      # Find each invitee in the Users table
      invitees.each do |invitee|
        user = User.find_by(id: invitee.user_id).username
        users_array.push(user)
      end
      # Add all the users of the event as User to the @users array
      @users[event] = users_array
    end
    
  end

  def new
    @event = Event.new
    @friends = current_user.friends
  end

  def create

    # eventually autogenerate a stream link, or give the users one idk
    @event = Event.new(event_params)
    # Leave this as current time + a day for now
    # When setting it, make sure is a future time.
    # Also need an invitee list.
    
    @event.scheduled_time = Time.now + 24 * 60


    # add something about session's user here
    @event.user_id = current_user.id
    if !@event.save
      flash[:danger] = "Event creation failed"
      render 'new'
    end

    # Add Invitations to the invitee table
    invitees = params[:attendees]
    invitees.each do |invited_id| 
      Invitee.create(user_id: invited_id, event_id: @event.id)
    end

    flash[:success] = "Event created"
    redirect_to '/events'
  end

  def event_screen
    @event_id = params[:event_id]
    @event = Event.find_by(id: params[:event_id])
    
      regex = /youtube.com.*(?:\/|v=)([^&$]+)/
      @regex_object= @event.stream_link.match(regex)
      if !@regex_object.nil? then
        @yt_id = @event.stream_link.match(regex)[1]
      end
  end
  


  private
    def event_params
      params.require(:event).permit(:title, :stream_link, :attendees)
    end
end
