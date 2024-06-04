class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  has_many :cart_items
  has_many :carts, through: :cart_items
end
