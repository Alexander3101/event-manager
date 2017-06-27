class RoomsController < ApplicationController
  def index
    @rooms = Room.paginate(page: params[:page])
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room
    else
      redirect_to '/rooms'
    end
  end

  def room_params
    params.require(:room).permit(:title, :description, :begin_work_time, :end_work_time)
  end
end
