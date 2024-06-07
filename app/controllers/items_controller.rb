class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :load_items_by_tag, only: [:bracelets, :boucles_oreilles, :colliers, :piece_unique]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    if @item
      @item_tags = @item.item_tags
    else
      flash[:error] = "Item not found"
      redirect_to items_path
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def bracelets
    @items = Item.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Bracelet") })
  end

  def boucles_oreilles
    @items = Item.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Boucles d'Oreilles") })
  end

  def colliers
    @items = Item.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Collier") })
  end

  def piece_unique
    @items = Item.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Pièce Unique") })
  end

  def marque_page
    @items = Item.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Marque Page") })
  end

  def porte_cles
    @items = Item.joins(:item_taggings).where(item_taggings: { item_tag_id: ItemTag.find_by(name: "Porte Clés") })
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
    params.require(:item).permit(:name, :description, :price, :image, item_tag_ids: [])
  end

  def load_items_by_tag
    @items = Item.with_tag(tag_name_from_action)
  end

  def tag_name_from_action
    action_name.tr('_', ' ')
  end
end
