class EventsController < ApplicationController
  def index
    @events = Event.where('end_datetime > ?', DateTime.now).order(:begin_datetime).paginate(page: params[:page])
  end

  def show
    @event = Event.find(params[:id])
    session[:return_to] = request.original_url
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(author_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

  def event_params
    params.require(:event).permit(:title, :begin_datetime, :end_datetime, :user_id)
  end
end
