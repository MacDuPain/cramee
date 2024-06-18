class TagsController < ApplicationController
  # Action pour afficher les articles associés à un tag spécifique
  def show
    @tag = Tag.find(params[:id])  # Trouve le tag à partir de l'ID passé en paramètre
    @items = @tag.items  # Récupère tous les articles associés à ce tag
  end
end
