class CreateJoinTableRoomsEvents < ActiveRecord::Migration[5.1]
  def change
    create_join_table :rooms, :events do |t|
      t.index :room_id
      t.index :event_id
    end
  end
end
