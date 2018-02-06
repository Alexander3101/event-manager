class RoomsController < ApplicationController
  def index
    @rooms = Room.paginate(page: params[:page])
  end

  def show
    @room = Room.find(params[:id])
    #session[:return_to] = request.original_url
  end

  def show_print
    @begin_date = params[:begin_date] ? params[:begin_date] : DateTime.now.strftime("%Y.%m.%d")
    @end_date = params[:end_date] ? params[:end_date] : DateTime.now.next_month.strftime("%Y.%m.%d")
    @room = Room.find(params[:id])
    @events = Event.where("room_id = ? and date >= ? and date <= ? and archive = ?", @room.id, @begin_date, @end_date, false)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", layout: false   # Excluding ".pdf" extension.
      end
    end
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room
    else
      render 'new'
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])

    if @room.update(room_params)
      redirect_to @room
    else
      render 'edit'
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
