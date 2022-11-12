class Api::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.includes(posts: [:comments]).find(params[:user_id])
    @posts = @user.posts.paginate(page: 1, per_page: 5)
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end
end
