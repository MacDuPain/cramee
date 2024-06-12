class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :authorize_admin, only: [:destroy]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to reviews_path, notice: 'Votre avis a été ajouté avec succès.'
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path, notice: 'Avis supprimé avec succès.'
  end

  private

  def review_params
    params.require(:review).permit(:name, :content)
  end

  def authorize_admin
    redirect_to(root_path, alert: 'Accès interdit.') unless current_user.admin?
  end
end