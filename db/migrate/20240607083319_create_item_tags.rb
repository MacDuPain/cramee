class CreateItemTags < ActiveRecord::Migration[7.1]
  def change
    create_table :item_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
