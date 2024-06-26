class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :mark_as_processed]

  def index
    @new_orders = Order.where(is_processed: false)
    @processed_orders = Order.where(is_processed: true)
  end

  def mark_as_processed
    @order.update(is_processed: true)
    redirect_to orders_path, notice: 'La commande a été marquée comme traitée'
  end

  def show
  end

  private

  def set_order
    if current_user.is_admin?
      @order = Order.find(params[:id])
    else
      @order = current_user.orders.find(params[:id])
    end
  end

  def items
    @order.order_items
  end

  def subtotal
    items.sum { |order_item| order_item.item.price * order_item.quantity }
  end

  def total_price
    subtotal + delivery_fee
  end

  def delivery_fee
    case subtotal
    when 0..19
      4
    when 20..49
      6
    else
      0
    end
  end
end
