class Tag < ApplicationRecord
  has_many :taggings
  has_many :topics, through: :taggings
end
