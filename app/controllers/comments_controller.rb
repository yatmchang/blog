class CommentsController < ApplicationController
before_action :authenticate_user!, except: [:show, :index]
    def new
      @comment = Comment.new
    end
    def create
      @comment = Comment.new comment_params
      @post = Post.find params[:post_id]
      @comment.user = current_user
      @comment.post = @post
      @comments = Comment.order(created_at: :desc)
      if @comment.save
        redirect_to post_path(@post)
      else
        render "/posts/show"
      end
    end

    def destroy
      post = Post.find params[:post_id]
      comment = Comment.find params[:id]
      comment.destroy
      redirect_to post_path(post)
    end

  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "please sign in" unless session[:user_id].present?
  end
