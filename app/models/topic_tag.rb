class TopicTag < ApplicationRecord
  has_many :topic_taggings
  has_many :topics, through: :topic_taggings
end
