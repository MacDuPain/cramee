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
  validate :validate_email_format

  private

  def password_complexity
    return if password.blank?

    types = 0
    types += 1 if password =~ /[a-z]/ # Lowercase
    types += 1 if password =~ /[A-Z]/ # Uppercase
    types += 1 if password =~ /[0-9]/ # Numbers
    types += 1 if password =~ /[^a-zA-Z0-9]/ # Special characters

    if types < 2
      errors.add :password, 'Le mot de passe ne contient pas au moins deux des catégories précisées ci dessous'
    end
  end

  def validate_email_format
    return if email.blank? || email =~ /\A[\w+\-.]+@(gmail\.com|outlook\.com|yahoo\.com|aol\.com|icloud\.com|protonmail\.com|zoho\.com|yandex\.com|mail\.com|gmx\.com|outlook\.fr|yahoo\.fr|aol\.fr|icloud\.fr|protonmail\.fr|zoho\.fr|yandex\.fr|mail\.fr|gmx\.fr)\z/i

    unless email =~ /\.(fr|com)\z/i
      errors.add :email, 'doit se terminer par .fr ou .com'
    end
  end
end
