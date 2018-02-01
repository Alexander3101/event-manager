class AddArchiveFieldToEvents < ActiveRecord::Migration[5.1]
  def change
    change_table :events do |t|
      t.boolean :archive, default: false
    end
  end
end
