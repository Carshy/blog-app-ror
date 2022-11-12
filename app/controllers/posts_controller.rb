class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    if current_user.nil?
      redirect_to new_user_session_path
      return
    end
    @posts = if current_user.role?
               @user.posts.includes(:comments)
             else
               @user.posts.includes(:comments, :author)
             end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @id = current_user.id
    @post = Post.new
  end

  def create
    @post = Post.new(title: post_params[:title], text: post_params[:text], user: current_user)
    flash[:notice] = if post.save
                       'Post created successfully'
                     else
                       'Error'
                     end
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @post.destroy
    redirect_to user_post_path(@user.id, @post.id)
  end
end
