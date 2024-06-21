class User < ApplicationRecord
  after_create :send_welcome_email
  after_create :create_cart
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :password_complexity
  validate :validate_email_format

  private

  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver_later
  end

  def password_complexity
    return if password.blank?

    types = 0
    types += 1 if password =~ /[a-z]/ # Lowercase
    types += 1 if password =~ /[A-Z]/ # Uppercase
    types += 1 if password =~ /[0-9]/ # Numbers
    types += 1 if password =~ /[^a-zA-Z0-9]/ # Special characters

    if types < 2
      errors.add :base, 'Le mot de passe ne contient pas au moins deux types de caractères'
    end

    if password.length < 8
      errors.add :base, 'Le mot de passe est trop court (minimum 8 caractères)'
    end
  end

  def validate_email_format
    return if email.blank? || email =~ /\A[\w+\-.]+@(gmail\.com|outlook\.com|yahoo\.com|aol\.com|icloud\.com|protonmail\.com|zoho\.com|yandex\.com|mail\.com|gmx\.com|outlook\.fr|yahoo\.fr|aol\.fr|icloud\.fr|protonmail\.fr|zoho\.fr|yandex\.fr|mail\.fr|gmx\.fr)\z/i

    unless email =~ /\.(fr|com)\z/i
      errors.add :email, 'doit se terminer par .fr ou .com'
    end
  end
end
