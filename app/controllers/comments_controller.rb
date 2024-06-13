class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @topic, notice: 'Commentaire ajouté avec succès!'
    else
      redirect_to @topic, alert: 'Le commentaire ne peut pas être vide.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
