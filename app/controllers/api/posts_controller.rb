class Api::PostsController < ApplicationController

  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @posts = @user.posts
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end
end
