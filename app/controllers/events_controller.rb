class EventsController < ApplicationController

  def show
  end

  def new
    @event = Event.new
  end

  def create

    # eventually autogenerate a stream link, or give the users one idk
    @event = Event.new(event_params)
    # add something about session's user here
    @event.user_id = User.all.sample.id
    if @event.save
      redirect_to '/'
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
