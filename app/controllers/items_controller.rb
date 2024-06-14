class ItemsController < ApplicationController
  # Avant chaque action du contrôleur, configure l'objet @item pour les actions spécifiées
  before_action :set_item, only: [:show, :edit, :update]
  # Avant les actions spécifiques, charge les articles en fonction du tag
  before_action :load_items_by_tag, only: [:bracelets, :boucles_oreilles, :colliers, :piece_unique]

  # Action pour afficher tous les articles, en fonction du rôle de l'utilisateur
  def index
    if current_user&.is_admin?
      @items = Item.all
    else
      @items = Item.where(visible_on_site: true)
    end
  end

  # Action pour afficher le formulaire de création d'un nouvel article
  def new
    @item = Item.new
  end

  # Action pour créer un nouvel article
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Le produit a été créé avec succès !'
    else
      render :new
    end
  end

  # Action pour afficher les détails d'un article spécifique
  def show
    # Le before_action :set_item a déjà configuré @item
    if @item
      @item_tags = @item.item_tags
    else
      flash[:error] = "Article non trouvé"
      redirect_to items_path
    end
  end

  # Action pour afficher le formulaire de modification d'un article
  def edit
    # Le before_action :set_item a déjà configuré @item
  end

  # Action pour mettre à jour les informations d'un article
  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'L\'article a été mis à jour avec succès.'
    else
      render :edit
    end
  end

  # Actions pour afficher les articles filtrés par tag spécifique (bracelets, boucles d'oreilles, colliers, pièces uniques, etc.)
  def bracelets
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Bracelet") })
  end

  def boucles_oreilles
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Boucles d'Oreilles") })
  end

  def colliers
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Collier") })
  end

  def piece_unique
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Pièce Unique") })
  end

  def marque_page
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Marque Page") })
  end

  def porte_cles
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Porte Clés") })
  end

  # Action pour afficher les articles en stock
  def stocked_items
    @items = Item.where(in_stock: true)
  end

  private

  # Méthode privée pour configurer l'objet @item en fonction de l'ID ou du tag
  def set_item
    if params[:id].to_i.to_s == params[:id]
      @item = Item.find(params[:id])
    else
      @item = Item.with_tag(params[:id]).first
    end
  end

  # Méthode privée pour filtrer et autoriser les paramètres d'un article
  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :in_stock, :visible_on_site, item_tag_ids: [])
  end

  # Méthode privée pour charger les articles en fonction du tag spécifique pour les actions concernées
  def load_items_by_tag
    @items = Item.with_tag(tag_name_from_action)
  end

  # Méthode privée pour récupérer le nom du tag à partir du nom de l'action
  def tag_name_from_action
    action_name.tr('_', ' ')
  end

  # Méthode privée pour récupérer tous les articles visibles sur le site
  def visible_items
    Item.where(visible_on_site: true)
  end
end