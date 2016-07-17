class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @fav = Favorite.new
    @post = Post.find params[:post_id]
    @fav.post = @post
    @fav.user = current_user
    respond_to do |format|
      if @fav.save
        format.html {redirect_to post_path(@post), notice: "Added to favorites"}
        format.js {render :create_success}
      else
        format.html {redirect_to post_path(@post), alert: "Didn't work..."}
        format.js {render :create_failure}
      end
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @fav  = current_user.favorites.find params[:id]
    respond_to do |format|
      @fav.destroy
      format.html {redirect_to post_path(@post), notice: "Removed from favorites" }
      format.js {render :create_failure }
    end
  end

  def index
    @posts = current_user.favorited_posts
  end

end
