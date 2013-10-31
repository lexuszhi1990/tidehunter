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
    root = Nokogiri::XML(request.body.read).root
    @receiver = root.xpath("ToUserName").children.text
    @sender = root.xpath("FromUserName").children.text
    @send_time = Time.at(root.xpath("CreateTime").text.to_i)
    @keyword = root.xpath("Content").children.text
    @message_type = root.xpath("MsgType").children.text
    @message_id = root.xpath("MsgId").text.to_i

    @search_results = siralize_school_data Weixin::http_getor(@keyword)

    logger.info "receiver :#{@receiver}"
    logger.info "sender :#{@sender}"
    logger.info "send_time :#{@send_time}"
    logger.info "keyword :#{@keyword}"
    logger.info "message_id :#{@message_id}"
    logger.info "message_type :#{@message_type}"
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

    def siralize_school_data(school)
      school["name"] + "\n.Rank : " + school["rank"] + school["summary"]
    end

    def weixin_params
      params.permit(:xml => [:ToUserName, :FromUserName, :CreateTime, :MsgType, :Content, :FuncFlag])
    end
end
