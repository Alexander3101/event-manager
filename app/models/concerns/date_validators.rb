module date_validators
  extend ActiveSupport::Concern

  class Event_validator < ActiveModel::Validator
    def validate(record)
      if (self.end_datetime - self.begin_datetime).to_i/60 < 15
        record.errors[:text] << 'Длительность < 15 минут'
      end
    end
  end

  class Room_validator < ActiveModel::Validator
    def validate(record)
      if (self.end_work_time - self.begin_work_time).to_i/60 < 15
        record.errors[:text] << 'Длительность < 15 минут'
      end

      if (self.end_work_time - self.begin_work_time).to_i/3600 > 24
        record.errors[:text] << 'Длительность > 1 дня'
      end
    end
  end

  class Order_validator < ActiveModel::Validator
    def validate(record)
      if (self.end_datetime - self.begin_datetime).to_i/60 < 15
        record.errors[:text] << 'Длительность < 15 минут'
      end

      if self.end_datetime > self.event.end_datetime or self.begin_datetime < self.event.begin_datetime
        record.errors[:text] << 'Мимо события'
      end

      if self.end_datetime.minute + 60*self.end_datetime.hour > self.room.end_work_time.minute + 60*self.room.end_work_time.hour or
        self.begin_datetime.minute + 60*self.begin_datetime.hour < self.room.begin_work_time.minute + 60*self.room.begin_work_time.hour

        record.errors[:text] << 'Мимо комнаты'
      end

      self.room.orders.each do |order|
        if (self.begin_datetime < order.begin_datetime and self.end_datetime > order.begin_datetime) or
          (self.begin_datetime < order.end_datetime and self.end_datetime > order.end_datetime) or
          (self.begin_datetime > order.begin_datetime and self.end_datetime < order.end_datetime)

          record.errors[:text] << 'Пересечение событий'
        end
      end
      
    end
  end

end
