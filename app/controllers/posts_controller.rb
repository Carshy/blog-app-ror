class PostsController < ApplicationController
  # load_and_authorize_resource

  # before_action :set_post, only: :show

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    # if current_user.nil?
    # redirect_to new_user_session_path
    # return
    # end
    # @posts = if current_user.role?
    #            @user.posts.includes(:comments)
    #          else
    #            @user.posts.includes(:comments, :author)
    #          end
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post Created Successfully'
      redirect_to user_posts_path
    else
      render :new
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @post.destroy
    redirect_to user_posts_path(@user.id, @post.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
