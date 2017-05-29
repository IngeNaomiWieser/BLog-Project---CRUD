class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'Comment created'
      redirect_to @post      #redirect to @post, so the same as saying: post_path(@post)
    else
      flash[:notice] = 'Problem creating comment'
      render 'posts/show'
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to @post, notice: 'Comment deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
