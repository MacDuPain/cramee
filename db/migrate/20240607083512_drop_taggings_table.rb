class DropTaggingsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :taggings
  end

  def down
    create_table :taggings do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end
  end
end
