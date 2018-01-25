class EventsController < ApplicationController
  def index
    #@events = Event.where('end_datetime > ?', DateTime.now).order(:begin_datetime).paginate(page: params[:page])
    @events = Event.where(room_id: params[:room_id]).order(:begin_datetime).paginate(page: params[:page])
  end

  def show
    @event = Event.find(params[:id])
    session[:return_to] = request.original_url
  end

  def new
    @event = Event.new
    respond_to do |format|
      format.html do
        render 'new', room_id: params[:room_id]
      end
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event.room
    else
      flash[:notice] = @event.errors['text'].last
      render 'new', room_id: @event.room_id
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event.room
    else
      flash[:notice] = @event.errors['text'].last
      render 'edit', room_id: @event.room_id
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

  def event_params
    params.require(:event).permit(:title, :description, :begin_datetime, :end_datetime, :room_id, :organizer_id, :lector_id, :user_id)
  end

  def assist
    respond_to do |format|
      format.html do
        render partial: 'events/assist', locals: { room: Room.find(params[:room_id]) }
      end
    end
  end

end
