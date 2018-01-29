class EventsController < ApplicationController
  def index
    #@events = Event.where('end_time > ?', DateTime.now).order(:begin_time).paginate(page: params[:page])
    @events = Event.where(room_id: params[:room_id]).order(:begin_time).paginate(page: params[:page])
  end

  def show
    @event = Event.find(params[:id])
    session[:return_to] = request.original_url
  end

  def new
    @event = Event.new
    @rooms = Room.all
    @room_id = params[:room_id]
    @date = params[:date]
    flash[:notice] = ""
    respond_to do |format|
      format.html do
        render partial: 'new', room_id: params[:room_id], date: params[:date]
      end
    end
  end

  def create
    @event = Event.new(event_params)
    @rooms = Room.all
    flash[:notice] = ""
    respond_to do |format|
      if @event.lector_id == 0
        @event.lector_id = Lector.find_or_create_by(name: params.permit(:new_lector)[:new_lector]).id
      end

      if @event.organizer_id == 0
        @event.organizer_id = Organizer.find_or_create_by(name: params.permit(:new_organizer)[:new_organizer]).id
      end

      if @event.save
        if params.permit(:repeatly).has_key? :repeatly
          create_repeatly_events
        end

        format.html { redirect_to @event.room }
      else
        flash[:notice] = @event.errors['text'].last
        format.html { render partial: 'new', room_id: @event.room_id, date: @event.date }
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
    @rooms = Room.all
    @room_id = params[:room_id]
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
    params.require(:event).permit(:title, :description, :date, :begin_time, :end_time, :room_id, :organizer_id, :lector_id, :user_id)
  end

  def create_repeatly_events
    case params.permit(:period)[:period]
    when "Каждый день"
      period = 1.day
    when "Каждую неделю"
      period = 7.days
    when "Каждый месяц"
      period = 1.month
    end
    date = DateTime.parse(event_params[:date]) + period
    begin_time = Time.parse(event_params[:begin_time])
    end_time = Time.parse(event_params[:end_time])
    max_date = Date.parse(params.permit(:max_date)[:max_date])
    max_date.change(hour: 23)
    while date <= max_date
      Event.create(
        title: event_params[:title],
        description: event_params[:description],
        date: date,
        begin_time: begin_time,
        end_time: end_time,
        room_id: event_params[:room_id],
        organizer_id: event_params[:organizer_id],
        lector_id: event_params[:lector_id],
        user_id: event_params[:user_id]
      )
      date += period
    end
  end

  def assist
    respond_to do |format|
      format.html do
        render partial: 'events/assist', locals: { room: Room.find(params[:room_id]) }
      end
    end
  end

end
