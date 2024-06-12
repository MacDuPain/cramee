class DeliveryInfo < ApplicationRecord
  belongs_to :order

  validates :nom, presence: true
  validates :prenom, presence: true
  validates :adresse, presence: true
  validates :code_postal, presence: true, format: { with: /\A\d+\z/, message: "doit contenir uniquement des chiffres" }
  validates :ville, presence: true

end
