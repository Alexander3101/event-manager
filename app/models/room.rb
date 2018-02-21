class Room < ApplicationRecord
  include DateValidators
  include ActiveModel::Validations

  has_many :events, dependent: :destroy

  # проверка на присутствие
  validates :title, :begin_work_time, :end_work_time, presence: true

  validates_with RoomValidator

  def events_betweeb_date(begin_date,end_date,archive = false)
    self.events.where(date: (begin_date..end_date)).where(archive: archive).order(:date).order(:begin_time)
  end
end
