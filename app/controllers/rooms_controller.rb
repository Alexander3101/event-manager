class RoomsController < ApplicationController
  def index
    @rooms = Room.paginate(page: params[:page])
  end

  def show
    @room = Room.find(params[:id])
  end

  def admin_index
    @rooms = Room.paginate(page: params[:page])
  end

  def show_print
    @begin_date = Date.parse(params[:begin_date])
    @end_date = Date.parse(params[:end_date])
    @room = Room.find(params[:id])
    @events = Event.where("room_id = ? and date >= ? and date <= ? and archive = ?", @room.id, l(@begin_date, format: :db), l(@end_date, format: :db), false).order(:date).order(:begin_time)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@room.title} events", layout: false   # Excluding ".pdf" extension.
      end
    end
  end

  def new
    @room = Room.new
    @room.begin_work_time = Time.parse("12:00")
    @room.end_work_time = Time.parse("21:00")
    respond_to do |format|
      format.html do
        render partial: 'new'
      end
    end
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to request.referrer }
      else
        format.html { render partial: 'new' }
      end
    end
  end

  def edit
    @room = Room.find(params[:id])
    respond_to do |format|
      format.html do
        render partial: 'edit'
      end
    end
  end

  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to request.referrer }
      else
        format.html { render partial: 'edit' }
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    redirect_to rooms_path
  end

  def room_params
    params.require(:room).permit(:title, :description, :begin_work_time, :end_work_time)
  end
end
