class StaticPagesController < ApplicationController
  def about
  end

  def landing_page
    @items = Item.all
  end
end
