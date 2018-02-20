class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable

  has_many :events, dependent: :destroy

  # проверка на присутствие
  validates :email, presence: true
  # на всякий случай, проверка уникальности email, хотя добавлять пользователей не будем
  validates :email, uniqueness: true

  def self.find_or_create_by_email(email,role = 'user')
    user = User.find_or_create_by(email: email)
    user.update_attributes(role: role) unless user.nil?
    return user
  end
end
