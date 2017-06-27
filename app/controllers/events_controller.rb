class EventsController < ApplicationController
  def index
    @events = Event.paginate(page: params[:page])
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      redirect_to '/events'
    end
  end

  def event_params
    params.require(:event).permit(:title, :begin_datetime, :end_datetime, :user_id)
  end
end
