class CreateTopicTags < ActiveRecord::Migration[7.1]
  def change
    create_table :topic_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
