class DeviseExecutors < ActiveRecord::Migration[5.1]
  def change
    create_table :executors do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
