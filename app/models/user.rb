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

  validate :password_complexity
  validates :email, format: { with: /\A[\w+\-.]+@(gmail\.com|outlook\.com|yahoo\.com|aol\.com|icloud\.com|protonmail\.com|zoho\.com|yandex\.com|mail\.com|gmx\.com|outlook\.fr|yahoo\.fr|aol\.fr|icloud\.fr|protonmail\.fr|zoho\.fr|yandex\.fr|mail\.fr|gmx\.fr)\z/i, message: "doit être une adresse email valide de services populaires" }

  private

  def password_complexity
    return if password.blank?

    unless password.length >= 8
      errors.add :password, 'must be at least 8 characters long'
    end

    types = 0
    types += 1 if password =~ /[a-z]/ # Lowercase
    types += 1 if password =~ /[A-Z]/ # Uppercase
    types += 1 if password =~ /[0-9]/ # Numbers
    types += 1 if password =~ /[^a-zA-Z0-9]/ # Special characters

    if types < 2
      errors.add :password, 'must include at least two of the following: uppercase letters, lowercase letters, numbers, and special characters'
    end
  end
end
