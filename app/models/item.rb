class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :item_taggings, dependent: :destroy
  has_many :item_tags, through: :item_taggings
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :order_items
  has_many :orders, through: :order_items
  has_one_attached :image
  accepts_nested_attributes_for :item_tags

  def self.with_tag(tag_name)
    joins(:item_tags).where(item_tags: { name: tag_name })
  end
end
