class SessionsController < ApplicationController
 
  def new
    
  end

  def create
    #binding.pry
    user = User.new(name: params[:username], email: params[:email], password: params[:password])
    if user and user.authenticate(params[:password])
      flash[:notice] = "Welcome to Here"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "Wrong user"
      redirect_to login_path
    end
  end

  def destroy
      session[:user_id] = nil
      flash[notice] = "OK, You have logged out"
      redirect_to root_path
    
  end

end
