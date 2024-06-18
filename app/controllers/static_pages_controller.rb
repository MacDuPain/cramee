class StaticPagesController < ApplicationController
  # Action pour afficher la page "À propos"
  def about
  end

  # Action pour afficher la page d'accueil (landing page)
  def landing_page
    @items = Item.all
  end

  # Action pour les mentions légales
  # Cette action est vide car nous allons directement rendre une page statique
  def mentions_legales
  end
end
