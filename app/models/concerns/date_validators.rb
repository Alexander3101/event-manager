
module DateValidators
  # Проверяет валидность даты/времени (конец раньше начала, пересечение, выход из промежутка...)
  extend ActiveSupport::Concern

  class EventValidator < ActiveModel::Validator
    def validate(record)
      if record.date.blank? || record.begin_time.blank? || record.end_time.blank?
        record.errors[:text] << 'Неправильная дата'
        return
      end

      if (record.end_time - record.begin_time).to_i / 60 < 15
        record.errors[:text] << 'Длительность < 15 минут'
      end

      if record.room.blank?
        record.errors[:text] << 'Нет комнаты'
        return
      end

      if record.end_time.min + 60 * record.end_time.hour > record.room.end_work_time.min + 60 * record.room.end_work_time.hour ||
         record.begin_time.min + 60 * record.begin_time.hour < record.room.begin_work_time.min + 60 * record.room.begin_work_time.hour

        record.errors[:text] << 'Мимо комнаты'
      end

      record.room.events.where(archive: false).each do |event|
        if event.id != record.id
          if event.date == record.date
            if (record.begin_time < event.begin_time && record.end_time > event.begin_time) ||
               (record.begin_time < event.end_time && record.end_time > event.end_time) ||
               (record.begin_time >= event.begin_time && record.end_time <= event.end_time)

              record.errors[:text] << 'Пересечение событий'
            end
          end
        end
      end
    end
  end

  class RoomValidator < ActiveModel::Validator
    def validate(record)
      if record.begin_work_time.blank? || record.end_work_time.blank?
        record.errors[:text] << 'Неправильная дата'
        return
      end

      if (record.end_work_time - record.begin_work_time).to_i / 60 < 15
        record.errors[:text] << 'Длительность < 15 минут'
      end

      if (record.end_work_time - record.begin_work_time).to_i / 3600 > 24
        record.errors[:text] << 'Длительность > 1 дня'
      end
    end
  end

end
