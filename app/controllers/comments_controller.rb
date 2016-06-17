class CommentsController < ApplicationController

    def new
      @comment = Comment.new
    end
    def create
      @comment = Comment.new comment_params
      @post = Post.find params[:post_id]
      @comment.post = @post
      @comments = Comment.order(created_at: :desc)
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

    def update
        @comment = Comment.find params[:id]
        comment_params = params.require(:comment).permit(:body)
        if @comment.update comment_params
          redirect_to comment_path(@comment)
        else
          render :edit
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
