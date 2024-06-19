class UsersController < ApplicationController
  before_action :authenticate_user!  # Assure que l'utilisateur est connecté pour accéder à toutes les actions

  # Action pour afficher le profil de l'utilisateur actuel
  def show
    @user = current_user  # Récupère l'utilisateur actuellement connecté
    @orders = @user.orders  # Récupère toutes les commandes de l'utilisateur
  end

  # Action pour afficher le formulaire d'édition du profil de l'utilisateur actuel
  def edit
    @user = current_user  # Récupère l'utilisateur actuellement connecté
  end

  # Méthode pour vérifier si l'utilisateur est un administrateur
  def admin?
    self.admin  # Vérifie si l'utilisateur a le rôle d'administrateur
  end

  private

  # Méthode pour définir l'utilisateur courant, utilisée pour les filtres
  def set_user
    @user = current_user  # Récupère l'utilisateur actuellement connecté
  end
end
