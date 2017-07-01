class UsersController < ApplicationController
  def personal
  end

  def show
    @user = User.find(params[:id])
    @events = Event.all
  end
end
