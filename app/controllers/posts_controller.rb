class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_id(params[:id])
    @comment = Comment.new
  end

  def create
    #binding.pry
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Post Success"
      redirect_to posts_path
    else
      render :new
    end
  end

  def new
    #binding.pry
    @post = Post.new
  end

end
