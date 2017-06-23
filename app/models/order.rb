class Order < ApplicationRecord
  belongs_to :room, dependent: :destroy
  belongs_to :event, dependent: :destroy
end
