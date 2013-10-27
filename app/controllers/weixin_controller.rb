# -*- encoding : utf-8 -*-
class WeixinController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def index
    render :text => params[:echostr]
  end

  def show
    render :text => params[:echostr]
  end

  def create
    if params[:xml][:MsgType] == "text"
      render "echo", :formats => :xml
    end
  end

  private
    def check_weixin_legality
      puts request.method + Time.current.to_s
      array = ["justfortoken1", params[:timestamp], params[:nonce]].sort
      render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
    end
end
