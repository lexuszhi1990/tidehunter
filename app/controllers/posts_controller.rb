class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

  def create
    binding.pry
    @post = Post.create(params[:post])
    redirect_to posts_path
  end

  def new
    #binding.pry
    @post = Post.new
  end

end
