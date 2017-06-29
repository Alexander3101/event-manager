class HomeController < ApplicationController
  def index
    @events_top = Event.where('end_datetime > ?', DateTime.now).order(:begin_datetime).limit(10)
  end
end
