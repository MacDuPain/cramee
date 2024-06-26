class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :load_items_by_tag, only: [:bracelets, :boucles_oreilles, :colliers, :piece_unique]

  def index
    if current_user&.is_admin?
      @items = Item.all
    else
      @items = Item.where(visible_on_site: true)
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Le produit a été créé avec succès !'
    else
      render :new
    end
  end

  def show
    if @item
      @item_tags = @item.item_tags
    else
      flash[:error] = "Article non trouvé"
      redirect_to items_path
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'L\'article a été mis à jour avec succès.'
    else
      render :edit
    end
  end

  def bracelets
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Bracelet") })
  end
  def boucles_oreilles
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Boucle d'oreille") })
  end
  def colliers
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Collier") })
  end
  def piece_unique
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Pièce unique") })
  end
  def marque_page
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Marque page") })
  end

  def autres
    @items = visible_items.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Autres") })
  end

  def stocked_items
    @items = Item.where(in_stock: true)
  end

  private

  def set_item
    if params[:id].to_i.to_s == params[:id]
      @item = Item.find(params[:id])
    else
      @item = Item.with_tag(params[:id]).first
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :in_stock, :visible_on_site, item_tag_ids: [])
  end

  def load_items_by_tag
    @items = Item.with_tag(tag_name_from_action)
  end

  def tag_name_from_action
    action_name.tr('_', ' ')
  end

  def visible_items
    Item.where(visible_on_site: true)
  end
end
