class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @items = @tag.items
  end
end
