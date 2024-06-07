class DropTagsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :tags
  end

  def down
    create_table :tags do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
