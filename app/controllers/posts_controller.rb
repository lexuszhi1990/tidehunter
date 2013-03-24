class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def create
    #binding.pry
    @post = Post.new(params[:post])
    if @post.save
      flash[:success] = "Post Success"
      redirect_to posts_path
    else
      flash[:error] = @post.errors.full_messages.join(',')
      render :new
    end
  end

  def new
    #binding.pry
    @post = Post.new
  end

end
