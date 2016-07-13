class FavouritesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = current_user.favourited_posts
  end

  def create
    post = Post.find params[:post_id]
    f = Favourite.new(post: post, user: current_user)
    if f.save
      redirect_to post_path(post)
    else
      redirect_to post_path(post)
    end

  end

  def destroy
    post = Post.find params[:post_id]
    f = Favourite.find params[:id]
    f.destroy
    redirect_to post_path(post)
  end

end
