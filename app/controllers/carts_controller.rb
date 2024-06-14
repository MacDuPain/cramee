class CartsController < ApplicationController
  # Avant chaque action dans ce contrôleur, vérifier que l'utilisateur est authentifié
  before_action :authenticate_user!

  # Avant certaines actions spécifiques, définir le panier actuel de l'utilisateur
  before_action :set_cart, only: [:show, :edit, :destroy, :confirm_order]

  # Action pour afficher le panier actuel de l'utilisateur
  def show
    @cart_items = @cart.cart_items
    @total_price = @cart.cart_items.sum do |cart_item|
      if cart_item.quantity.present?
        cart_item.item.price * cart_item.quantity.to_i
      else
        0
      end
    end

    # Si le panier est vide, initialiser @total_price à zéro
    @total_price ||= 0
  end

  # Action pour éditer un panier existant
  def edit
    @cart = Cart.find(params[:id])
  end

  # Action pour créer un nouveau panier pour l'utilisateur actuel
  def create
    @cart = current_user.build_cart
    if @cart.save
      redirect_to @cart
    else
      render :new
    end
  end

  # Action pour mettre à jour la quantité d'un article dans le panier de l'utilisateur
  def update_item_quantity
    cart_item = current_user.cart.items.find_by(id: params[:item_id])

    if cart_item.nil?
      render json: { status: 'error', message: 'Cart item not found' }, status: :not_found
    elsif cart_item.update(quantity: params[:quantity])
      render json: { status: 'success', message: 'Quantity updated', total_price: current_user.cart.total_price }, status: :ok
    else
      render json: { status: 'error', message: 'Failed to update quantity' }, status: :unprocessable_entity
    end
  end

  # Action pour supprimer le panier actuel de l'utilisateur
  def destroy
    @cart = current_user.cart
    @cart.destroy
    redirect_to root_path, notice: 'Votre panier a été supprimé avec succès'
  end

  # Action pour ajouter un article au panier de l'utilisateur
  def add_item
    @cart = current_user.cart || current_user.create_cart
    item = Item.find(params[:item_id])
    quantity = params[:quantity].to_i

    cart_item = @cart.cart_items.find_by(item: item)

    if cart_item
      cart_item.quantity += quantity
      cart_item.save
    else
      @cart.cart_items.create(item: item, quantity: quantity)
    end

    redirect_to @cart, notice: 'L\'article a été ajouté à votre panier.'
  end

  # Action pour retirer un article du panier de l'utilisateur
  def remove_item
    @cart = current_user.cart
    item = Item.find(params[:item_id])
    cart_item = @cart.cart_items.find_by(item_id: item.id)

    if cart_item.quantity > 1
      cart_item.quantity -= 1
      cart_item.save
    else
      @cart.items.delete(item)
    end

    redirect_to @cart, notice: 'Cet article a été retiré de votre panier'
  end

  # Action pour confirmer une commande à partir du panier actuel de l'utilisateur
  def confirm_order
    @cart = current_user.cart
    if @cart.items.any?
      order = current_user.orders.create
      @cart.cart_items.each do |cart_item|
        order.order_items.create(item: cart_item.item, quantity: cart_item.quantity, price: cart_item.item.price)
      end
      @cart.items.clear
      redirect_to order_path(order), notice: 'Votre commande a été passée avec succès.'
    else
      redirect_to @cart, alert: 'Votre panier est vide.'
    end
  end

  private

  # Méthode privée pour définir le panier actuel de l'utilisateur
  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  # Méthode privée pour définir les paramètres autorisés lors de la création/modification d'un panier
  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
