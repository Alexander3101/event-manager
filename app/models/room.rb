class Room < ApplicationRecord
  include DateValidators
  include ActiveModel::Validations

  has_many :events, dependent: :destroy

  # проверка на присутствие
  validates :title, :begin_work_time, :end_work_time, presence: true

  validates_with RoomValidator
end
