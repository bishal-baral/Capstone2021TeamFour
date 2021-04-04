class EventsController < ApplicationController

  def show
    @event = Event.where(user_id: current_user.id )
  end

  def new
    @event = Event.new
    @friends = current_user.friends
    # @friends = current_user.friends.map{ |friend| [friend.username, friend.id] }
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
    if @event.save
      redirect_to '/events'
    else
      # Figure out how to turn this into a path var
      render 'new'
    end
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
      params.require(:event).permit(:title, :stream_link, :invitees)
    end
end
