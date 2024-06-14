# app/controllers/topics_controller.rb
class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]  # Authentifie l'utilisateur pour toutes les actions sauf :index et :show
  before_action :set_topic, only: [:show]  # Avant l'action :show, défini le sujet à afficher

  # Action pour afficher tous les sujets, ordonnés par date de création décroissante
  def index
    @topics = Topic.all.order(created_at: :desc)
  end

  # Action pour afficher un sujet spécifique
  def show
    @topic = Topic.find(params[:id])  # Trouve le sujet à partir de l'ID passé en paramètre
    @new_comment = Comment.new  # Initialise un nouvel objet Comment pour le formulaire de commentaire
  end

  # Action pour créer un nouveau sujet
  def new
    @topic = Topic.new  # Initialise un nouvel objet Topic pour le formulaire de création
  end

  # Action pour sauvegarder un nouveau sujet créé par l'utilisateur actuel
  def create
    @topic = current_user.topics.build(topic_params)  # Crée un sujet associé à l'utilisateur actuel
    if @topic.save
      redirect_to @topic, notice: 'Le sujet a été créé avec succès.'
    else
      render :new  # Si la sauvegarde échoue, réaffiche le formulaire de création
    end
  end

  private

  # Méthode pour définir le sujet à afficher pour l'action :show
  def set_topic
    @topic = Topic.find(params[:id])  # Trouve le sujet à afficher en fonction de l'ID passé en paramètre
  end

  # Méthode pour définir les paramètres acceptés pour la création ou la mise à jour d'un sujet
  def topic_params
    params.require(:topic).permit(:title, :content, tag_ids: [])  # Autorise les paramètres :title, :content et :tag_ids
  end
end
