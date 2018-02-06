class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    dtn = DateTime.now
    @events = Event.where(archive: false, user_id: @user.id).where("date > ? or (date = ? and end_time > ?)", dtn.strftime("%Y-%m-%d"), dtn.strftime("%Y-%m-%d"), dtn.strftime("%H:%M")).order(:date).order(:begin_time).paginate(page: params[:page], :per_page => 10)
  end

  def archive
    @user = User.find(params[:id])
    @events = Event.where(archive: true, user_id: @user.id).order(:date).reverse_order.order(:begin_time).paginate(page: params[:page], :per_page => 10)
  end

  def past
    @user = User.find(params[:id])
    dtn = DateTime.now
    @events = Event.where(archive: false, user_id: @user.id).where("date <= ? or (date = ? and end_time <= ?)", dtn.strftime("%Y-%m-%d"), dtn.strftime("%Y-%m-%d"), dtn.strftime("%H:%M")).order(:date).reverse_order.order(:begin_time).paginate(page: params[:page], :per_page => 10)
  end

end
