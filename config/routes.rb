Tidehunter::Application.routes.draw do
  root to: "articles#index"
  resources :articles, only:  [:index, :show]
  resources :messages, only:  [:index]

  # used for weixin api
  resources :weixin, only: [:show, :create, :index]

  # grape api
  mount API => '/'

  devise_for :users, :controllers => { :registrations => "registrations" }

  namespace :gandor do
    resources :articles
    resources :messages
    resources :users

    root to: "dashboard#index"
  end
end
