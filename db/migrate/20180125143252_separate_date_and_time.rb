class SeparateDateAndTime < ActiveRecord::Migration[5.1]
  def change
    change_table :events do |t|
      t.remove :begin_datetime, :end_datetime
      t.date :date, null: false
      t.time :begin_time, null: false
      t.time :end_time, null: false
    end
  end
end
