class Api::CommentsController < ApplicationController
  before_action :set_user, only: %i[create show index]
  before_action :set_post, only: %i[create show index]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    comment = Comment.new(author: @user, post: @post, text: comments_params[:text])
    if comment.save
      render json: comment
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
