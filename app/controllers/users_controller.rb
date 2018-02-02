class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = Event.all.order(:begin_time).paginate(page: params[:page])
  end
  def archive
    @user = User.find(params[:id])
    @events = Event.where(room_id: params[:room_id], archive: true).order(:begin_time).paginate(page: params[:page])
  end
end
