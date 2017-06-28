class Order < ApplicationRecord
  belongs_to :room, dependent: :destroy
  belongs_to :event, dependent: :destroy

  # проверка на присутствие
  validates :begin_datetime, :end_datetime, :room_id, :event_id, presence: true
  # проверка на integer и not_null
  validates :user_id, :room_id, numericality: { only_integer: true }
end
