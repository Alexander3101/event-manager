class Event < ApplicationRecord
  has_and_belongs_to_many :rooms
  belongs_to :user, dependent: :destroy
  has_many :orders

  validates :title, :begin_datetime, :end_datetime, :user_id, presence: true
end
