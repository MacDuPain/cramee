# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new 
    @comment = Comment.new
  
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @topic, notice: 'Comment was successfully created.'
    else
      render 'topics/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end