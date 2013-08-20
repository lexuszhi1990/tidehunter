class MessagesController < ApplicationController
  inherit_resources
  actions :index
  respond_to :html, :xml, :json

  protected
  def collection
    @messages = Message.recent.page(params[:page]).per_page(10)
  end
end
