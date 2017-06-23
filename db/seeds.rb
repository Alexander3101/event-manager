# Пользователи
8.times do
  email_tmp = Faker::Internet.email
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
10.times do
  title_tmp = Faker::Book.title
  Event.create(
  title: title_tmp,
  description: title_tmp + title_tmp + title_tmp,
  begin_datetime: DateTime.now,
  end_datetime: DateTime.now + 6000,
  user_id: rand(1..9)
  )
end
