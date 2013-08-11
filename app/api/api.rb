class API < Grape::API
  prefix "api"

  mount Reader::API

  # used for test "/api/say"
  get 'say' do
    {hello: "hello world"}
  end
end
