class CreateLectors < ActiveRecord::Migration[5.1]
  def change
    create_table :lectors do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
