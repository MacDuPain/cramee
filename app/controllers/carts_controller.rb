class CartsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_cart, only: [:show, :edit, :destroy, :confirm_order]

  def show
    @cart_items = @cart.cart_items
    @total_price = @cart.cart_items.sum do |cart_item|
      if cart_item.quantity.present?
        cart_item.item.price * cart_item.quantity.to_i
      else
        0
      end
    end
    @total_price ||= 0
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = current_user.build_cart
    if @cart.save
      redirect_to @cart
    else
      render :new
    end
  end

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

  def destroy
    @cart = current_user.cart
    @cart.destroy
    redirect_to root_path, notice: 'Votre panier a été supprimé avec succès'
  end

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

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def cart_params
    params.require(:cart).permit(:user_id)
  end
end
