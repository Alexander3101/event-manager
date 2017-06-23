class AddEventToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :event_id, :integer
  end
end
