class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :authorize_admin, only: [:destroy, :toggle_approval]

  # Action pour afficher tous les avis
  def index
    @reviews = if current_user&.is_admin?
                 Review.all
               else
                 Review.where(approved: true)
               end
  end

  # Action pour afficher le formulaire de création d'un nouvel avis
  def new
    @review = Review.new
  end

  # Action pour créer un nouvel avis
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: 'Votre commentaire a été ajouté avec succès !'
    else
      render :new
    end
  end

  # Action pour supprimer un avis
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path, notice: 'Votre avis a été supprimé avec succès '
  end

  # Méthode pour approuver un avis
  def toggle_approval
    @review = Review.find(params[:id])
    @review.update(approved: !@review.approved)
    redirect_back(fallback_location: reviews_path)
  end

  private

  # Méthode privée pour définir les paramètres autorisés pour la création d'un avis
  def review_params
    params.require(:review).permit(:name, :content)
  end

  # Méthode privée pour autoriser uniquement les administrateurs à effectuer l'action de suppression
  def authorize_admin
    redirect_to(root_path, alert: 'Accès interdit.') unless current_user.is_admin?
  end
end
