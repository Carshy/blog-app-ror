class Api::CommentsController < ApplicationController
  before_action :set_user, only: %i[create show index]
  before_action :set_post, only: %i[create show index]

  def index
    @id = current_user.id
    @comment = Comment.new
    render json: @comment
  end

  def show
    render json: @comment
  end

  def new
    @post = Post.find(params[:post_id])
    comments = @post.comments.build
    render json: comments
  end

  def create
    post = Post.find(params[:id])
    comment = Comment.new(user: current_user, post:, text: comments_params[:text])
    respond_to do |format|
      if comment.save
        format.json { render :show, status: :created, location: comment }
      else
        format.json { render json: comment.errors, status: :unprocessable_entity }
      end
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
