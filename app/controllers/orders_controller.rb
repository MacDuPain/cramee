class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]


  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
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
    when 0..20
      4
    when 20..49
      6
    else
      0
    end
  end
end
