class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = Event.all
  end
end
