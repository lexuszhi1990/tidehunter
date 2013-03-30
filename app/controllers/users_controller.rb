class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
  end

  def index
    @users = User.all
  end

  def new
  end

  def create
    #binding.pry
    user = User.new(name: params[:username], email: params[:email], password: params[:password])
    if user.save
      flash[:notice] = "Welcome to Here"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "Wrong user"
      user.errors.delete(:password_digest)
      render :new
    end
  end
end
