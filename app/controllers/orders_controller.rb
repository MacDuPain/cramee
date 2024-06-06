class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders.find(params[:id])
  end

  def subtotal
    items.sum(:price)
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
