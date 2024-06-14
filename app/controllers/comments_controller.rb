class CommentsController < ApplicationController
  # Assure que toutes les actions du contrôleur nécessitent que l'utilisateur soit authentifié
  before_action :authenticate_user!

  # Action pour afficher le formulaire de création d'un nouveau commentaire
  def new
    @comment = Comment.new
  end

  # Action pour créer un nouveau commentaire associé à un topic spécifique
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user

    # Sauvegarde le commentaire dans la base de données
    if @comment.save
      redirect_to @topic, notice: 'Votre commentaire a été ajouté avec succès!'
    else
      # En cas d'échec de la sauvegarde, redirige l'utilisateur vers la page précédente avec un message d'erreur
      redirect_back fallback_location: @topic, alert: 'Le champ de commentaire ne peut pas être vide.'
    end
  end

  private

  # Méthode privée pour filtrer et autoriser les paramètres du commentaire
  def comment_params
    params.require(:comment).permit(:content)
  end
end
