module Msg
  class API < Grape::API

    version 'v1', using: :path
    format :json

    helpers do
      def access_token!(token)
        error!('401 Unauthorized', 401) unless ["abcdef"].include?(token)
      end
    end

    resource :message do

      desc "Return a message."
      params do
        requires :id, type: Integer, desc: "Message id."
      end
      route_param :id do
        get do
          Message.find(params[:id])
        end
      end

      desc "Create a status."
      params do
        requires :state, type: String, desc: "Your Article body."
        requires :token, type: String, desc: "Your access token."
      end
      post do
        access_token!(params[:token])
        Message.create!({
          body: params[:state]
        })
      end
    end
  end
end
