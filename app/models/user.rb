class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable

  has_many :events, dependent: :destroy

  # проверка на присутствие
  validates :email, :password, presence: true
  # на всякий случай, проверка уникальности email, хотя добавлять пользователей не будем
  validates :email, uniqueness: true
end
