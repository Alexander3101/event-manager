users_number = 8
events_number = 10
rooms_number = 6

# Пользователи
users_number.times do
  email_tmp = Faker::Internet.unique.email
  User.create(
  email: email_tmp,
  password: email_tmp[0,2] + "12345"
  )
end

User.create(
email: "adminishe@admins.net",
password: "admin1",
role: "admin"
)

User.create(
email: "admin@admins.net",
password: "admin2",
role: "admin"
)

# События
events_number.times do |i|
  title_tmp = Faker::Book.title
  Event.create(
  title: title_tmp,
  description: title_tmp + title_tmp + title_tmp,
  begin_datetime: DateTime.now + i.minutes,
  end_datetime: DateTime.now + 10.days,
  user_id: rand(0..users_number-1)
  )
end

# Комнаты
rooms_number.times do |i|
  Room.create(
  title: "room_" + (i + rand(1..6)*10).to_s,
  begin_work_time: Time.new(2000, 01, 01, 9, 0, 0, '+03:00'),
  end_work_time: Time.new(2000, 01, 01, 18, 0, 0 '+03:00'),
  description: "this is a room"
  )
end

Event.all.each do |e|
  Room.all.each do |r|
    if rand(0..4) == 0
      e.rooms << r
    end
  end
end
