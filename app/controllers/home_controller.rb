class HomeController < ApplicationController
  def index
    @events_top = Event.where('end_time > ?', DateTime.now).order(:begin_time).limit(10)
  end
end
