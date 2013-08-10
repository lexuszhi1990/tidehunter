class API < Grape::API
  format :json
  desc "Read Articles"

  get 'say' do
    {hello: "hello"}
  end

  resource :read do
    desc "Return a public timeline."
    get :big do
      Article.all.count
    end
  end
end
