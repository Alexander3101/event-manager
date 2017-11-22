class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.datetime :begin_datetime, null: false
      t.datetime :end_datetime, null: false
      t.text :description

      # пользователь, создавший событие
      t.integer :user_id, null: false
      # организатор
      t.integer :organizer_id, null: false
      # тот, кто проведёт
      t.integer :executor_id, null: false
      # где проведут
      t.integer :room_id, null: false

      t.timestamps
    end
  end
end
