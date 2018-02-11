class Event < ApplicationRecord
  include DateValidators
  include ActiveModel::Validations

  belongs_to :room
  belongs_to :user
  belongs_to :organizer
  belongs_to :lector

  # проверка на присутствие
  validates :title,  :date, :begin_time, :end_time, :user_id, :organizer_id, :lector_id, :room_id, presence: true
  # проверка на integer и not_null
  validates :user_id, :organizer_id, :lector_id, :room_id, numericality: { only_integer: true }

  validates_with EventValidator

  def self.current_events(user_id)
    dtc = DateTime.current
    self.where(archive: false, user_id: user_id).where("date > ? or (date = ? and end_time > ?)",
      I18n.l(dtc, format: :date_db), I18n.l(dtc, format: :date_db), I18n.l(dtc)).order(:date).order(:begin_time)
  end

  def self.past_events(user_id)
    dtc = DateTime.current
    self.where(archive: false, user_id: user_id).where("date < ? or (date = ? and end_time <= ?)",
      I18n.l(dtc, format: :date_db), I18n.l(dtc, format: :date_db), I18n.l(dtc)).order(:date).reverse_order.order(:begin_time)
  end

  def self.canceled_events(user_id)
    self.where(archive: true, user_id: user_id).order(:date).reverse_order.order(:begin_time)
  end

end
