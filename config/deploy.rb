# require 'ruby-debug'
# RVM bootstrap
require 'rvm/capistrano'
set :rvm_ruby_string, 'ruby-1.9.3-p448'
set :rvm_type, :user

set :app_server, 'gandor'
set :app_url, 'gamdor'

# repo details
set :scm, :git
# need to clean shared/cached-copy if changed repository
# set :repository, "ssh://git@beansmile.com:2244/ib5k-web"
set :repository, "git@github.com:lexuszhi1990/tidehunter.git"

# set :branch, "develop"
set :branch, "master"
set :git_enable_submodules, 1




# bundler bootstrap
require 'bundler/capistrano'
set :bundle_without, [:darwin, :development, :test]

# main details
set :application, app_server
role :web, app_server
role :app, app_server
role :db,  app_server, :primary => true

# # Multi stage
# # https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
# # https://github.com/VinceMD/Scem/wiki/Deploying-on-production
# require gem 'capistrano-ext'
# require 'capistrano/ext/multistage'
# set :stages, %w(production staging)
# set :default_stage, "staging" # require config/deploy/staging.rb

# server details
default_run_options[:pty] = true # apparently helps with passphrase prompting
ssh_options[:forward_agent] = true # tells cap to use my local private key
# set :deploy_to, "/var/www/#{app_server}"
set :deploy_to, "/var/www/tidehunter"
set :deploy_via, :remote_cache
set :user, "deploy"
set :use_sudo, false
# set :shared_children, %w(system log pids) + %w(config)

# # integrate whenever
# # when using bundler
# set :whenever_command, "bundle exec whenever"
# # when using different environments
# set :whenever_environment, defer { stage }
# require "whenever/capistrano"
# # https://github.com/javan/whenever/blob/master/lib/whenever/capistrano.rb



# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    %w{database}.each do |file|
      run "ln -nfs #{shared_path}/config/#{file}.yml #{release_path}/config/#{file}.yml"
    end

    # link dirs in public/
    %w{uploads}.each do |dir|
      run "mkdir -p #{shared_path}/public/#{dir}"
      run "ln -nfs #{shared_path}/public/#{dir} #{release_path}/public/#{dir}"
    end
  end

  desc "Initialize configuration using example files provided in the distribution"
  task :upload_config do
    %w{config}.each do |dir|
      run "mkdir -p #{shared_path}/#{dir}"
    end

    Dir["config/*.yml.example"].each do |file|
      top.upload(File.expand_path(file), "#{shared_path}/config/#{File.basename(file, '.example')}")
    end
  end
end

after 'deploy:setup', 'deploy:upload_config'
after 'deploy:update_code', 'deploy:symlink_shared'

namespace :deploy do
  desc 'Visit the app'
  task :visit_web do
    system "open #{app_url}"
  end
end
after 'deploy:restart', 'deploy:visit_web'

namespace :db do

  desc "Create db for current env"
  task :create do
    run "cd #{current_path}; bundle exec rake db:create RAILS_ENV=#{rails_env}"
    puts 'could be able to run `cap deploy:migrate` now'
  end

  desc "Populates the Production Database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end

end

# http://guides.rubyonrails.org/asset_pipeline.html#precompiling-assets
# https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy/assets.rb
load 'deploy/assets' unless ARGV.join == "deploy:update"
# then we got these tasks:
# cap deploy:assets:clean      # Run the asset clean rake task.
# cap deploy:assets:precompile # Run the asset precompilation rake task.

namespace :remote do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    hostname = find_servers_for_task(current_task).first
    command = "cd #{current_path} && bundle exec rails console #{fetch(:rails_env)}"
    if fetch(:rvm_ruby_string)
      # set rvm shell and get ride of "'"
      # https://github.com/wayneeseguin/rvm/blob/master/lib/rvm/capistrano.rb
      # default_shell == "rvm_path=$HOME/.rvm/ $HOME/.rvm/bin/rvm-shell '1.9.2-p136'"
      rvm_shell = %{rvm_path=$HOME/.rvm/ $HOME/.rvm/bin/rvm-shell "#{fetch(:rvm_ruby_string)}"}
      command = %{#{rvm_shell} -c "#{command}"}
    else
      command = %{source ~/.profile && "#{command}"}
    end
    exec %{ssh -l #{user} #{hostname} -t '#{command}'}
  end

  desc 'run rake task. e.g.: `cap remote:rake db:version`'
  task :rake do
    ARGV.values_at(Range.new(ARGV.index('remote:rake')+1,-1)).each do |rake_task|
      top.run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake #{rake_task}"
    end
    exit(0)
  end

  desc 'run remote command. e.g.: `cap remote:run "tail -n 10 log/production.log"`'
  task :run do
    command=ARGV.values_at(Range.new(ARGV.index('remote:run')+1,-1))
    top.run "cd #{current_path}; RAILS_ENV=#{rails_env} #{command*' '}"
    exit(0)
  end

  desc 'run specified rails code on server. e.g.: `cap remote:runner p User.all` or `cap remote:runner "User.all.each{ |u| p u }"`'
  task :runner do
    command=ARGV.values_at(Range.new(ARGV.index('remote:runner')+1,-1))
    top.run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rails runner '#{command*' '}'"
    exit(0)
  end

  desc 'tail log on remote server'
  task :tail_log do
    top.run "tail -f #{current_path}/log/#{rails_env}.log" do |channel, stream, data|
      puts "#{data}"
      break if stream == :err
    end
    exit(0)
  end
end

# namespace :app do
#   desc 'recreate versions for photos'
#   task :recreate_versions_photos, :roles => :app do
#     codes = 'Photo.all.map {|p| p.image.recreate_versions! }'
#     ARGV = ["remote:runner", codes]
#     remote.runner
#   end
# end


# for backup db:
# https://github.com/webficient/capistrano-recipes
# gem install capistrano-recipes
# require 'capistrano_recipes'
# cap deploy:setup_dirs        # |DarkRecipes| Create shared dirs
# cap db:mysql:dump            # Performs a compressed database dump
# cap db:mysql:fetch_dump      # Downloads the compressed database dump to this machine


# Tips
# setup dir
# run `cap deploy:setup` to init dirs on remote server
# run `cap deploy:check` should see "You appear to have all necessary dependencies installed"

# setup db
# run `cap deploy:update`
# run `cap db:create` to create the db if necessary

# run `cap deploy:migrate` for first migration
# then for usual deploy, just run:
# run `cap deploy:migrations` Deploy and run pending migrations.
# or
# run `cap deploy` Deploy without running migrations.

# get version via cap:
# cap COMMAND="cd /var/www/#{app_server}/current; bundle exec rake db:version RAILS_ENV=production" invoke

# run `cap -T` or `cap -vT` to see more tasks info

namespace :update do
  desc "Dump remote database into tmp/, download file to local machine, import into local database"
  task :database do
    # config
    remote_db_yml_path          = "#{shared_path}/config/database.yml"
    remote_db_yml_on_local_path = "tmp/database_#{rails_env}.yml"

    # First get the remote database config file so that we can read in the database settings
    get remote_db_yml_path, remote_db_yml_on_local_path

    # load the remote settings within the database file
    remote_settings = YAML::load_file(remote_db_yml_on_local_path)[rails_env]

    remote_sql_file_path        = "#{current_path}/tmp/#{rails_env}-#{remote_settings["database"]}-dump.sql"
    remote_sql_gz_file_path     = "#{remote_sql_file_path}.gz"
    local_sql_file_path         = "tmp/#{rails_env}-#{remote_settings["database"]}-#{Time.now.strftime("%Y-%m-%d_%H:%M:%S")}.sql"
    local_sql_gz_file_path      = "#{local_sql_file_path}.gz"

    # we also need the local settings so that we can import the fresh database properly
    local_settings = YAML::load_file("config/database.yml")[rails_env]

    # dump the remote database and store it in the current path's tmp directory.
    run "PGPASSWORD='#{remote_settings['password']}' pg_dump -U #{remote_settings["username"]} #{"-h '#{remote_settings["host"]}'" if remote_settings["host"]} -c -O '#{remote_settings["database"]}' > #{remote_sql_file_path}"

    # gzip db
    run "gzip -f #{remote_sql_file_path}"

    # download gz file to local
    get remote_sql_gz_file_path, local_sql_gz_file_path

    # unzip sql
    run_locally "gunzip #{local_sql_gz_file_path}"

    # import db to local db
    # may need to run `RAILS_ENV=production rake db:create` on local first
    run_locally("PGPASSWORD='#{local_settings['password']}' psql -U #{local_settings["username"]} -d #{local_settings["database"]} -f #{local_sql_file_path}")

    # now that we have the upated production dump file we should use the local settings to import this db.
  end

  desc "Mirrors the remote shared public directory with your local copy, doesn't download symlinks"
  task :shared_assets do
    run_locally "if [ -e public/system ]; then mv public/system public/system_back; fi"
    # using rsync so that it only copies what it needs
    run_locally("rsync --recursive --times --rsh=ssh --compress --human-readable --progress #{user}@#{app_server}:#{shared_path}/system/ public/system/")
  end
end

namespace :update_remote do
  desc "update the remote databse as the local database"
  task :database do
    input = ''
    # STDOUT.puts "Are you SURE to update the databse of remote?(YES)"
    # confirmation = STDIN.gets.chomp
    confirmation = Capistrano::CLI.ui.ask("Are you SURE to update the databse of remote?(YES)")
    abort "Interrupt.." unless confirmation == "YES"
    # config database.yml on both sides
    remote_db_yml_path          = "#{shared_path}/config/database.yml"
    remote_db_yml_on_local_path = "tmp/database_#{rails_env}.yml"

    # First get the local database config to remote
    get remote_db_yml_path, remote_db_yml_on_local_path

    # load the local settings within the database file
    local_settings = YAML::load_file("config/database.yml")[rails_env]

    # set the sql path on both sides
    local_sql_file_path = "tmp/#{rails_env}-#{local_settings['database']}-dump.sql"
    local_sql_gz_file_path = "#{local_sql_file_path}.gz"
    remote_sql_file_path = "#{current_path}/tmp/#{rails_env}-#{local_settings['database']}-#{Time.now.strftime("%Y-%m-%d_%H:%M:%S")}.sql"
    remote_sql_gz_file_path = "#{remote_sql_file_path}.gz"

    # we also need the remote settings so that we can import the fresh dataabse properly
    remote_settings = YAML::load_file(remote_db_yml_on_local_path)[rails_env]

    # dump the local database and store it in the tmp dir
    run_locally "PGPASSWORD='#{remote_settings['password']}' pg_dump  -U #{local_settings["username"]} #{"-h '#{local_settings["host"]}'" if local_settings["host"]} -c -O '#{local_settings["database"]}' > #{local_sql_file_path}"

    # gzip db
    run_locally "gzip -f #{local_sql_file_path}"

    # send the gz file to remote
    upload local_sql_gz_file_path, remote_sql_gz_file_path

    # unzip sql
    run "gunzip #{remote_sql_gz_file_path}"

    # import db to remote db
    # may need to run `RAILS_ENV=production rake db:create` on remote first
    run "PGPASSWORD='#{remote_settings['password']}' psql -U #{remote_settings['username']} -d #{remote_settings["database"]} -f #{remote_sql_file_path}"

    # now that we have the updated production dump file we should use the remote settings to import this db
  end

  desc "Mirrors the local shared public directory with the remote copy, doesn't download symlinks"
  task :shared_assets do
    run "cp -R #{shared_path}/system #{shared_path}/system_back"
    run_locally("rsync --recursive --times --rsh=ssh --compress --human-readable --progress public/system #{user}@#{app_server}:#{shared_path}/")
  end
end

namespace :debug_remote do
  desc "Print the production.log to make debug in the remote easy"
  task :log do
    run "tail -f #{current_path}/log/production.log"
  end
end