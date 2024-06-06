class CreateDeliveryInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_infos do |t|

      t.timestamps
    end
  end
end
