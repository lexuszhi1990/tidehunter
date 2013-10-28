class ApplicationController < ActionController::Base
  protect_from_forgery


  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.geek?
      gandor_root_url
    else
      # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
      # if use omniauth to login, request.env['omniauth.origin'] is automatically set.
      # request.env['omniauth.origin'] || session[:previous_url] || root_path
      root_path
    end
  end
end
