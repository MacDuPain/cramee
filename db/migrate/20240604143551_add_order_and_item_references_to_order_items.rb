class AddOrderAndItemReferencesToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_items, :order, null: false, foreign_key: true
    add_reference :order_items, :item, null: false, foreign_key: true
  end
end