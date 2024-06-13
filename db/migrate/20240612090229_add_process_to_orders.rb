class AddProcessToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :is_processed, :string, default: false
  end
end
