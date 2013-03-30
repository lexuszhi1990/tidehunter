class SessionsController < ApplicationController
 
  def new
    
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      flash[:notice] = "Welcome to Here"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "Wrong user"
      render :new
    end
  end

  def destroy
      session[:user_id] = nil
      flash[notice] = "OK, You have logged out"
      redirect_to root_path
  end

end
