class StaticPagesController < ApplicationController
  def about
  end

  def landing_page
    @items = Item.all
  end

  def mentions_legales
    # This action is empty because we will render a static page directly
  end
end
