set :app_server, 'lingzhi.me'
set :application, app_server
role :web, app_server
role :app, app_server
role :db,  app_server, :primary => true
set :deploy_to, "/var/www/tidehunter"
set :user, "deploy"
set :rvm_ruby_string, 'ruby-2.0.0-p247'
set :branch, "master"
