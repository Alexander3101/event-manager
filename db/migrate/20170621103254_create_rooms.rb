class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :title, null: false
      t.datetime :begin_work_time, null: false
      t.datetime :end_work_time, null: false
      t.text :description
      
      t.timestamps
    end
  end
end
