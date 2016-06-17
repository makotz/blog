class CommentsController < ApplicationController
  before_action find_comment:, only:[:show, :edit, :update, :destroy]

  def create
    @comment = Comment.new comment_params
    @post = Post.find params[:post_id]
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post)
    else
      render "/posts/show"
    end
  end


  def show
  end

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def edit
  end

  def update
    @post = Post.find params[:post_id]
    if @comment.update comment_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@comment.post)
  end

  def search
    @comment = Comment.new
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_comment
    @comment = Comment.find params[:id]
  end
end
