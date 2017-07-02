users_number = 8
events_number = 12
rooms_number = 6
datetime = DateTime.now.change(hour: 9)

# Пользователи
users_number.times do
  email_tmp = Faker::Internet.unique.email
  User.create(
    email: email_tmp,
    password: email_tmp[0, 2] + '12345'
  )
end

User.create(
  email: 'admin@example.com',
  password: 'password',
  role: 'admin'
)

User.create(
  email: 'admin@admins.net',
  password: 'admin2',
  role: 'admin'
)

puts "users created"

# События
events_number.times do |i|
  title_tmp = Faker::Book.title
  Event.create(
    title: title_tmp,
    description: title_tmp + title_tmp + title_tmp,
    begin_datetime: datetime + i.minutes,
    end_datetime: datetime + 10.days,
    user_id: rand(0..users_number - 1)
  )
end
Event.create(
  title: 'My_event',
  description: 'la - la - la',
  begin_datetime: datetime - 10.hours,
  end_datetime: datetime + 1.days,
  user_id: rand(0..users_number - 1)
)

Event.create(
  title: 'My_event_3',
  description: 'la - la - la',
  begin_datetime: datetime - 2.days,
  end_datetime: datetime - 1.days,
  user_id: rand(0..users_number - 1)
)

puts "events created"

# Комнаты
rooms_number.times do |i|
  Room.create(
    title: 'room_' + (i + rand(1..6) * 10).to_s,
    begin_work_time: Time.new(2000, 01, 01, 11, 0, 0, '+03:00'),
    end_work_time: Time.new(2000, 01, 01, 21, 0, 0, '+03:00'),
    description: 'this is a room'
  )
end

Event.all.each do |e|
  Room.all.each do |r|
    e.rooms << r if rand(0..4) == 0
  end
end

puts "rooms created"

# Брони
Room.all.each do |r|
  r.events.each_with_index do |e, i|
    b = e.begin_datetime.change(hour: 9, min: 0)
    o = Order.new(
      begin_datetime: b + i.hours,
      end_datetime: b + (i + 1).hours,
      room_id: r[:id],
      event_id: e[:id]
    )
    # Если по какой-то причине бронь не состоялась, удаляем связь комнаты с событием
    unless o.save
      e.rooms.destroy(r)
    end
  end
end

puts "orders created"
puts "success"
