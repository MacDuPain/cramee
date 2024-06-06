class User < ApplicationRecord
  after_create :create_cart
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :topics
  has_many :comments

  # Add username attribute
  validates :username, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_auth