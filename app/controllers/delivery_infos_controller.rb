class DeliveryInfosController < ApplicationController
  before_action :set_order

  def new
    @delivery_info = DeliveryInfo.new
  end

  def create
    @order = Order.find(params[:order_id])
    @delivery_info = @order.build_delivery_info(delivery_info_params)
    if @delivery_info.save
      redirect_to checkout_create_path(order_id: @order.id), notice: 'Informations de livraison enregistrées.'
    else
      render :new
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def delivery_info_params
    params.require(:delivery_info).permit(:nom, :prenom, :adresse, :code_postal, :ville)
  end
end
