class Tag < ApplicationRecord
  has_many :taggings
  has_many :topics, through: :taggings
  has_and_belongs_to_many :items
end
