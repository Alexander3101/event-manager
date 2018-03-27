class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :check_user, only: [:edit, :update, :destroy]

  def index
    @events = Event.where(room_id: params[:room_id], archive: false).order(:begin_time)
  end

  def personal
    case params[:state]
    when 'past'
      @past = 'active'
      @current = @canceled = nil
      @events = Event.past_events(current_user.id)
    when 'canceled'
      @canceled = 'active'
      @current = @past = nil
      @events = Event.canceled_events(current_user.id)
    else
      @current = 'active'
      @past = @canceled = nil
      @events = Event.current_events(current_user.id)
    end
  end

  def new
    @event = Event.new
    @event.room_id = params[:room_id]
    @event.date = params[:date] ? params[:date] : Date.today
    @event.begin_time = Time.parse("12:00")
    @event.end_time = Time.parse("12:30")
    @rooms = Room.all
    flash[:notice] = ""

    respond_to do |format|
      format.html { render partial: 'new' }
    end
  end

  def create
    @event = Event.new(event_params)
    @rooms = Room.all
    respond_to do |format|
      if @event.save
        create_repeatly_events if params.permit(:repeatly).has_key? :repeatly

        format.html { redirect_to request.referrer }
      else
        flash[:notice] = @event.errors['text'].last
        format.html { render partial: 'new' }
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
    @rooms = Room.all
    flash[:notice] = ""
    if Event.where("title = ? and id != ?", @event.title, @event.id).length != 0
      @repeatly = true
    else
      @repeatly = false
    end

    respond_to do |format|
      format.html { render partial: 'edit' }
    end
  end

  def update
    @event = Event.find(params[:id])
    @rooms = Room.all
    if Event.where("title = ? and id != ?", @event.title, @event.id).length != 0
      @repeatly = true
    else
      @repeatly = false
    end

    old_title = @event.title

    respond_to do |format|
      if @event.update(event_params)
        edit_repeatly_events(old_title) if params.permit(:change)[:change] == "future"
        create_repeatly_events if params.permit(:repeatly).has_key? :repeatly

        format.html { redirect_to request.referrer }
      else
        flash[:notice] = @event.errors['text'].last
        format.html { render partial: 'edit' }
      end
    end
  end

  def destroy
    deleting_event = Event.find(params[:id])
    case params.permit(:value)[:value]
    when "this"
      deleting_event.update(archive: true)
    when "future"
      deleting = Event.where("title = ? and room_id = ? and archive = ? and date >= ?", deleting_event.title, deleting_event.room_id, false, deleting_event.date)
    when "all"
      deleting = Event.where("title = ? and room_id = ? and archive = ?", deleting_event.title, deleting_event.room_id, false)
    end

    if deleting
      deleting.each do |event|
        event.update(archive: true)
      end
    end

    respond_to do |format|
      format.html { redirect_to request.referrer }
    end
  end

  private def event_params
    params.require(:event).permit(:title, :description, :date, :room_id, :user_id).merge(event_time_params).merge(organizer_and_lector_params)
  end

  private def event_time_params
    {
      begin_time: Time.parse(params.require(:event).permit(:begin_time)[:begin_time]),
      end_time: Time.parse(params.require(:event).permit(:end_time)[:end_time])
    }
  end

  private def organizer_and_lector_params
    par = params.require(:event).permit(:organizer_id, :lector_id)

    org = if par[:organizer_id] == "0"
      Organizer.find_or_create_by(name: params.permit(:new_organizer)[:new_organizer]).id
    else
      par[:organizer_id]
    end

    lec = if par[:lector_id] == "0"
      Lector.find_or_create_by(name: params.permit(:new_lector)[:new_lector]).id
    else
      par[:lector_id]
    end
    
    {
      organizer_id: org,
      lector_id: lec
    }
  end

  private def check_user
    unless current_user.role == "admin" || current_user.id == Event.find(params[:id]).user_id
      redirect_to "users/sign_in", :status => 401
    end
  end

  private def create_repeatly_events
    case params.permit(:period)[:period]
    when "Каждый день"
      period = 1.day
    when "Каждую неделю"
      period = 7.days
    when "Каждый месяц"
      period = 1.month
    end

    date = DateTime.parse(event_params[:date]) + period
    max_date = Date.parse(params.permit(:max_date)[:max_date])

    while date <= max_date
      e = Event.new(event_params)
      e.date = date
      e.save
      date += period
    end
  end

  private def edit_repeatly_events (old_title)
    Event.where("title = ? and room_id = ? and date > ?", old_title, @event.room_id, @event.date).each do |editable_event|
      editable_event.update(@event.attributes.except("id", "date"))
    end
  end

  private def assist
    respond_to do |format|
      format.html do
        render partial: 'events/assist', locals: { room: Room.find(params[:room_id]) }
      end
    end
  end

end
