class Order < ApplicationRecord
  include DateValidators
  include ActiveModel::Validations

  belongs_to :room
  belongs_to :event

  # проверка на присутствие
  validates :begin_datetime, :end_datetime, :room_id, :event_id, presence: true
  # проверка на integer и not_null
  validates :event_id, :room_id, numericality: { only_integer: true }

  validates_with OrderValidator
end
