class Order < ApplicationRecord
  belongs_to :room, dependent: :destroy
  belongs_to :event, dependent: :destroy

  validates :title, :begin_datetime, :end_datetime, :room_id, :event_id, presence: true
end
