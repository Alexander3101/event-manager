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
        render partial: 'new', room_id: params[:room_id]
      end
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save

      if params.permit(:repeatly).has_key? :repeatly
        begin_datetime = DateTime.parse(event_params[:begin_datetime]) + 1.day
        end_datetime = DateTime.parse(event_params[:end_datetime]) + 1.day
        max_date = DateTime.parse(params.permit(:max_date)[:max_date])
        max_date.change(hour: 23)
        while begin_datetime <= max_date
          Event.create(
            title: event_params[:title],
            description: event_params[:description],
            begin_datetime: begin_datetime,
            end_datetime: end_datetime,
            room_id: event_params[:room_id],
            organizer_id: event_params[:organizer_id],
            lector_id: event_params[:lector_id],
            user_id: event_params[:user_id]
          )
          begin_datetime += 1.day
          end_datetime += 1.day
        end
      end

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
