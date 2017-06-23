class Room < ApplicationRecord
  has_many :orders
  has_and_belongs_to_many :events

  validates :title, :begin_work_time, :end_work_time, :event_id, presence: true
end
