class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :require_user, :current_user, :logged_in?, :admin_user,
                :mark_down

  def require_user
    unless logged_in?
      flash[:error] = "Need to login"
      redirect_to login_path
    end
  end
  
  def current_user
    return false if session[:user_id].nil?
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def admin_user
      redirect_to root_path unless current_user and current_user.id != 5
  end

  def mark_down(text)
    Klog::Markdown.render(text)
  end

end
