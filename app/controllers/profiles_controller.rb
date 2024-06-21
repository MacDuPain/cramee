class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @orders = @user.orders
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Votre adresse e-mail a été modifiée avec succès"
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :other_attributes)
  end
end
