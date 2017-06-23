class RoomsController < ApplicationController
  def index
    @rooms = Room.paginate(page: params[:page])
  end
end
