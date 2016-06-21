class PostsController < ApplicationController
  before_action :authorize_owner, only: [:edit, :destroy, :update]
  before_action :authenticate_user!, only: [:new]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 10)
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update post_params
      redirect_to posts_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :category_id)
  end

  def authorize_owner
    unless can? :manage, @post
      redirect_to root_path, alert: "Access denied. Please sign in first."
    end
  end

  def authenticate_user!
    redirect_to root_path, alert: "please sign in" unless user_signed_in?
  end

end
