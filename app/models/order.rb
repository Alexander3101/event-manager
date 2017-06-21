class Order < ApplicationRecord
  belongs_to :room, dependent: :destroy
end
