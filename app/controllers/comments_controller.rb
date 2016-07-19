class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]


  def create
    @comment = Comment.new comment_params
    @post = Post.find params[:post_id]
    @comment.user = current_user
    @comment.post = @post
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post) }
        format.js {render :create_success}
      else
        format.html { render "/posts/show" }
        format.js {render :create_failure}
      end
    end
  end


  def show
    @comment = Comment.find params[:id]
  end

  def index
    @comments = Comment.order(created_at: :asc)
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post) }
      format.js {render }
    end
  end

  def search
    @comment = Comment.new
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end



end
