class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.datetime :begin_datetime, null: false
      t.datetime :end_datetime, null: false

      t.integer :room_id, null: false

      t.timestamps
    end
  end
end
