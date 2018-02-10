class RoomsController < ApplicationController
  def index
    @rooms = Room.paginate(page: params[:page])
  end

  def show
    @room = Room.find(params[:id])
    #session[:return_to] = request.original_url
  end

  def admin_index
    @rooms = Room.paginate(page: params[:page])
  end

  def show_print
    @begin_date = params[:begin_date] ? params[:begin_date] : DateTime.now.strftime("%Y-%m-%d")
    @end_date = params[:end_date] ? params[:end_date] : DateTime.now.next_month.strftime("%Y-%m-%d")
    @room = Room.find(params[:id])
    @events = Event.where("room_id = ? and date >= ? and date <= ? and archive = ?", @room.id, @begin_date, @end_date, false).order(:date).order(:begin_time)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", layout: false   # Excluding ".pdf" extension.
      end
    end
  end

  def new
    @room = Room.new
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
