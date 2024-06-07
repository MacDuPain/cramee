class User < ApplicationRecord
  after_create :create_cart
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
