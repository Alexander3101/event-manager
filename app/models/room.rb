class Room < ApplicationRecord
  has_many :orders
  has_and_belongs_to_many :events
end
