class Room < ApplicationRecord
  has_many :orders
  has_and_belongs_to_many :events

  # проверка на присутствие
  validates :title, :begin_work_time, :end_work_time, presence: true
end
