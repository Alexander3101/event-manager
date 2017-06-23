class HomeController < ApplicationController
  def index
    @events_top = Event.all.limit(5)
  end
end
