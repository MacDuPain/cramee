class DeliveryInfosController < ApplicationController
  # Avant chaque action du contrôleur, configure l'ordre actuel
  before_action :set_order

  # Action pour afficher le formulaire de création de nouvelles informations de livraison
  def new
    @delivery_info = DeliveryInfo.new
  end

  # Action pour créer de nouvelles informations de livraison associées à une commande spécifique
  def create
    @order = Order.find(params[:order_id])
    @delivery_info = @order.build_delivery_info(delivery_info_params)

    # Sauvegarde les informations de livraison dans la base de données
    if @delivery_info.save
      redirect_to checkout_create_path(order_id: @order.id), notice: 'Informations de livraison enregistrées.'
    else
      render :new
    end
  end

  private

  # Méthode privée pour configurer l'ordre actuel à partir de params[:order_id]
  def set_order
    @order = Order.find(params[:order_id])
  end

  # Méthode privée pour filtrer et autoriser les paramètres des informations de livraison
  def delivery_info_params
    params.require(:delivery_info).permit(:nom, :prenom, :adresse, :code_postal, :ville)
  end
end
