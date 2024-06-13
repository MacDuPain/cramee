module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_admin

    def index
      @orders_count = Order.count
      #@average_price = Order.average(:total_price)
      @orders = Order.includes(:user).order(created_at: :desc)
      # Ajouter d'autres statistiques nécessaires ici
    end

    private

    def check_if_admin
      redirect_to(root_path) unless current_user.is_admin?
    end
  end
end
