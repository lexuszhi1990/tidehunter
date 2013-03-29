class PostsController < ApplicationController
  before_filter find_post, :only => [:show, :update, :destroy, :edit]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
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

  def edit
    
  end

  def destroy
    
  end

  def update
    
  end

  private
  def find_post
    @post = Post.find_by_id(params[:id])
  end

end
