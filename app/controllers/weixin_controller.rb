# -*- encoding : utf-8 -*-
class WeixinController < ApplicationController
  respond_to :xml, :only => :create
  skip_before_filter :verify_authenticity_token
  before_filter :check_weixin_legality

  def index
    render :text => params[:echostr]
  end

  def show
    render :text => params[:echostr]
  end

  def create
    if params[:xml] and params[:xml][:MsgType] == "text"
      @resource = Weixin.http_getor params[:xml][:Content]
      render "text"
    end
  end

  private
    def check_weixin_legality
      array = ["justfortoken1", params[:timestamp], params[:nonce]].sort
      render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
    end
end
