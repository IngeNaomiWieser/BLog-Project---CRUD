class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    post_params = params.require(:post).permit(:title, :body, :category_id)
    @post = Post.new post_params
    if @post.save
      redirect_to posts_path
    else
      render :new      # you're not giving it a path, but a template
    end
  end

  def destroy
    p = Post.find params[:id]
    p.destroy
    redirect_to home_path
  end

end
