class AddVisibleOnSiteToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :visible_on_site, :boolean
  end
end
