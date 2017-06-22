class HomeController < ApplicationController
  def index
    @events_top = Event.where(:begin_datetime >= Time.now);
  end
end
