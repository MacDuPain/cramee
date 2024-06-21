class StaticPagesController < ApplicationController
  def about
  end

  def landing_page
    @items = Item.all
  end


  def mentions_legales
  end
end
