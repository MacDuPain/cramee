class CreateTopicTaggings < ActiveRecord::Migration[7.1]
  def change
    create_table :topic_taggings do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :topic_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
