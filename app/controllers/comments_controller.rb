class CommentsController < ApplicationController
  #Nu kunnen niet ingelogde users geen comments creeren of vernietigen.
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'Comment created'
      redirect_to @post      #redirect to @post, so the same as saying: post_path(@post)
    else
      flash[:alert] = 'Problem creating comment'
      render 'posts/show'
    end
  end

  # def destroy
  #   @post = Post.find params[:post_id]
  #   @comment = Comment.find params[:id]
  #   @comment.destroy
  #   redirect_to @post, notice: 'Comment deleted'
  # end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    if can? :destroy, @comment
      @comment.destroy
      redirect_to @post, notice: 'Comment deleted'
    else
      # head :unauthorized
      redirect_to @post, alert: "You can not remove a comment that is not yours."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
