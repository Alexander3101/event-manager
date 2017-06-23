class Event < ApplicationRecord
  has_and_belongs_to_many :rooms
  belongs_to :user, dependent: :destroy
  has_many :orders
end
