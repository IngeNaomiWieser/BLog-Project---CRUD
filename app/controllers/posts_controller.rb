class PostsController < ApplicationController

  #Nu kunnen niet ingelogde users alleen de posts en comments (index en show) zien, maar verder geen dingen creeren of vernietigen.
  before_action :authenticate_user!, except: [:index, :show]

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
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created'
      redirect_to posts_path  # or: @post
    else
      flash[:alert] = 'Problem creating your post'
      render :new      # you're not giving it a path, but a template
    end
  end

  def edit
    @categories = Category.all
    @post = Post.find params[:id]
    unless can? :edit, @post
      redirect_to @post, alert: 'You can not edit a post that is not yours.'
    end
  end

  def update
    post_params = params.require(:post).permit(:title, :body, :category_id)
    @post = Post.find params[:id]
    if cannot? :edit, @post
      redirect_to @post, alert: 'Acces denied. You can not edit a post that is not yours.'
    elsif @post.update(post_params)
      redirect_to @post, notice: 'Successfully updated!'
    else
      flash.now[:alert] = "Problem Updating"
      render :edit
    end
  end

  def destroy
    p = Post.find params[:id]
    if can? :destroy, p
      p.destroy
      redirect_to home_path, notice: 'Post deleted'
    else
      # head :unauthorized
      redirect_to post_path, alert: "You can not remove a post that is not yours."
    end
  end

end
