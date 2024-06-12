class AddInStockToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :in_stock, :boolean
  end
end
