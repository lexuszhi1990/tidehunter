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
    # @resource = Weixin.http_getor "harv"
    if params[:xml] and params[:xml][:MsgType] == "text"
      render "text", formats: :xml
    end
    render "echo", :formats => :xml
  end

  private
    def check_weixin_legality
      array = ["justfortoken1",  params["timestamp"], params["nonce"]]
      if params["timestamp"].nil? or
         params["nonce"].nil? or
         params[:signature] != Digest::SHA1.hexdigest(array.sort.join)
        render :text => "Forbidden", :status => 403
      end
    end

    def weixin_params
      params.permit(:xml => [:ToUserName :FromUserName :CreateTime :MsgType :Content :FuncFlag])
    end
end
