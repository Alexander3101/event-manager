class Event < ApplicationRecord
  include date_validators
  include ActiveModel::Validations

  has_and_belongs_to_many :rooms
  belongs_to :user, dependent: :destroy
  has_many :orders

  # проверка на присутствие
  validates :title, :begin_datetime, :end_datetime, :user_id, presence: true
  # проверка на integer и not_null
  validates :user_id, numericality: { only_integer: true }

  validates_with Event_validator
end
