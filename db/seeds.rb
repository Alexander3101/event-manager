users_number = 8
rooms_number = 6
organizers_number = 5
executors_number = 5
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

puts 'users created'

organizers_number.times do
  Organizer.create(
    name: Faker::Name.job_titles
  )
end

puts 'organizers created'

executors_number.times do
  Executor.create(
    name: Faker::Name.first_name
  )
end

puts 'executors created'

# Комнаты
rooms_number.times do |i|
  Room.create(
    title: 'room_' + (i + rand(1..6) * 10).to_s,
    begin_work_time: Time.new(2000, 1, 1, 11, 0, 0, '+03:00'),
    end_work_time: Time.new(2000, 1, 1, 21, 0, 0, '+03:00'),
    description: 'this is a room'
  )
end

puts 'rooms created'

# Брони
Room.all.each do |r|
  for i in 0..rand(1..5)
    Event.create(
      title: "My_#{r[:title]}_event #{i}",
      description: "event number #{i} in room #{r[:title]}",
      begin_datetime: b + i.hours,
      end_datetime: b + (i + 1).hours,
      room_id: r[:id],
      user_id: rand(0..users_number - 1)
      organizer_id: rand(0..organizers_number - 1)
      executor_id: rand(0..executors_number - 1)
    )
  end
end

puts 'events created'
puts 'success'
