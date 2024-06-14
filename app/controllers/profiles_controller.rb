class ProfilesController < ApplicationController
  before_action :authenticate_user!

  # Action pour afficher le profil de l'utilisateur courant
  def show
    @user = current_user
    @orders = @user.orders
  end

  # Action pour afficher le formulaire de modification du profil de l'utilisateur courant
  def edit
    @user = current_user
  end

  # Action pour mettre à jour le profil de l'utilisateur courant
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Adresse e-mail modifiée avec succès"
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  # Méthode privée pour définir les paramètres autorisés pour la mise à jour du profil utilisateur
  def user_params
    params.require(:user).permit(:email, :other_attributes) # Ajoutez d'autres attributs au besoin
  end
end
