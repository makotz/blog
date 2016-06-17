class CommentsController < ApplicationController

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
    @comment = Comment.find params[:id]
  end

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def destroy
    @comment = Comment.find params[:id]
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



end
