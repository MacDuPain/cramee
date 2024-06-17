class AddApprovedToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :approved, :boolean
  end
end
