class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_owner, only: [:edit, :destroy, :update]

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
    @comment = Comment.new
  end

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 10)
  end

  def edit
  end

  def update
    @post.slug = nil
    if @post.update post_params
      redirect_to posts_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.friendly.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :category_id)
  end

  def authorize_owner
    unless can? :manage, @post
      redirect_to new_session_path, alert: "Access denied. Please sign in first."
    end
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end

end
