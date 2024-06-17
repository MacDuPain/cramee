# app/controllers/topics_controller.rb
class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_topic, only: [:show]

  def index
    @topics = Topic.all.order(created_at: :desc)
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments.order(created_at: :desc)
  end


  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      redirect_to @topic, notice: 'Votre Topic a été créé avec succès'
    else
      render :new
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :content, tag_ids: [])
  end
end
