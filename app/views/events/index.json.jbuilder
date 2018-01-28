json.array!(@events) do |event|
  json.extract! event, :id
  json.extract! event, :title, :description
  json.extract! event, :user, :organizer, :lector
  json.start event.date.to_datetime.change(hour: event.begin_time.hour, min: event.begin_time.min)
  json.end  event.date.to_datetime.change(hour: event.end_time.hour, min: event.end_time.min)
  json.url event_url(event, format: :html)
end
