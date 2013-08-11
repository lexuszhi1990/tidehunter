module Reader
  class API < Grape::API

    version 'v1', using: :path
    format :json

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
      end
      post do
        Article.create!({
          body: params[:article]
        })
      end
    end
  end
end
