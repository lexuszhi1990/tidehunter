module Reader
  class API < Grape::API

    version 'v1', using: :path
    format :json

    helpers do
      def access_token!(token)
        error!('401 Unauthorized', 401) unless ["abcdef"].include?(token)
      end
    end

    resource :read do

      desc "Return a public timeline."
      get 'count' do
        Article.all.count
      end

      desc "Return a article."
      params do
        requires :id, type: Integer, desc: "Status id."
      end
      route_param :id do
        get do
          Article.find(params[:id])
        end
      end

      desc "Create a status."
      params do
        requires :article, type: String, desc: "Your Article body."
        requires :token, type: String, desc: "Your access token."
      end
      post do
        access_token!(params[:token])
        Article.create!({
          body: params[:article]
        })
      end
    end
  end
end
