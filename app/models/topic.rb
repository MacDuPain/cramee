class Topic < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :topic_taggings
  has_many :topic_tags, through: :topic_taggings
end
