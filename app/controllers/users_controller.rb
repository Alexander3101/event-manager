class UsersController < ApplicationController
  def events
    @events = Event.current_events(current_user.id)
  end

  def past
    @events = Event.past_events(current_user.id)
  end

  def canceled
    @events = Event.canceled_events(current_user.id)
  end
  
end
