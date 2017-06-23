class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :title, null: false
      t.time :begin_work_time, null: false
      t.time :end_work_time, null: false
      t.text :description

      t.timestamps
    end
  end
end
