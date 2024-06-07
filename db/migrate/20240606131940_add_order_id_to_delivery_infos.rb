class AddOrderIdToDeliveryInfos < ActiveRecord::Migration[7.1]
  def change
    add_column :delivery_infos, :order_id, :integer
  end
end
