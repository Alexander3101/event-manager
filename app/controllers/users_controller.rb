class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = Event.where("archive = ? and date >= ? and end_time >= ? and user_id = ?", false, DateTime.now, Time.now.change(year:2000,month:1,day:1).utc, @user.id).order(:begin_time).paginate(page: params[:page])
    @x = DateTime.now
    @y = DateTime.now.change(year:2000,month:1,day:1).utc
  end
  def archive
    @user = User.find(params[:id])
    @events = Event.where("archive = ? and user_id = ?", true, @user.id).order(:begin_time).paginate(page: params[:page])
  end
  def past
    @user = User.find(params[:id])
    @events = Event.where("archive = ? and date <= ? and end_time <= ? and user_id = ?", false, DateTime.now, Time.now.change(year:2000,month:1,day:1).utc, @user.id).order(:begin_time).paginate(page: params[:page])
    @x = @events.last.end_time
    @y = Time.now.change(year:2000,month:1,day:1).utc
  end

end
