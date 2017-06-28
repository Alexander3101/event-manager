class HomeController < ApplicationController
  def index
    @events_top = Event.where("end_datetime < ?", DateTime.now).limit(5)
  end
end
