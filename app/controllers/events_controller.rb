class EventsController < ApplicationController

  def show
    @event = Event.all
  end

  def new
    @event = Event.new
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


  private
    def event_params
      params.require(:event).permit(:user, :title)
    end
end
