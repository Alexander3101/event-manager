class Event < ApplicationRecord
  include DateValidators
  include ActiveModel::Validations

  has_and_belongs_to_many :rooms
  belongs_to :user
  has_many :orders, dependent: :destroy

  # проверка на присутствие
  validates :title, :begin_datetime, :end_datetime, :user_id, presence: true
  # проверка на integer и not_null
  validates :user_id, numericality: { only_integer: true }

  validates_with Event_validator
end
