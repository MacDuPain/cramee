class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :mark_as_processed]

  # Action pour afficher toutes les nouvelles commandes non traitées et les commandes traitées
  def index
    @new_orders = Order.where(is_processed: false)
    @processed_orders = Order.where(is_processed: true)
  end

  # Action pour marquer une commande comme traitée
  def mark_as_processed
    @order.update(is_processed: true)
    redirect_to orders_path, notice: 'La commande a été marquée comme traitée'
  end

  # Action pour afficher les détails d'une commande spécifique
  def show
    # Le before_action :set_order a déjà configuré @order
  end

  private

  # Méthode privée pour configurer l'objet @order en fonction du rôle de l'utilisateur
  def set_order
    if current_user.is_admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  # Méthode privée pour récupérer les articles de la commande
  def items
    @order.order_items
  end

  # Méthode privée pour calculer le sous-total de la commande
  def subtotal
    items.sum { |order_item| order_item.item.price * order_item.quantity }
  end

  # Méthode privée pour calculer le prix total de la commande, incluant les frais de livraison
  def total_price
    subtotal + delivery_fee
  end

  # Méthode privée pour calculer les frais de livraison en fonction du sous-total de la commande
  def delivery_fee
    case subtotal
    when 0..20
      4
    when 20..49
      6
    else
      0
    end
  end
end
