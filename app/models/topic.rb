class Topic < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :topic_taggings, dependent: :destroy
  has_many :topic_tags, through: :topic_taggings

  validates :title, presence: true
  validates :content, presence: true
end
