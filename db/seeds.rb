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
