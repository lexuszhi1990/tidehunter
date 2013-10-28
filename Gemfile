# source 'http://ruby.taobao.org'
source 'https://rubygems.org'

gem 'rails', '3.2.12'

# https://github.com/brianmario/mysql2
gem "mysql2", "~> 0.3.13"

# https://github.com/smartinez87/exception_notification
# http://rubygems.org/gems/exception_notification
gem "exception_notification", "~> 4.0.0"

# http://rubygems.org/gems/grape
# https://github.com/intridea/grape
# An opinionated micro-framework for creating REST-like APIs in Ruby
gem "grape", "~> 0.5.0"

# Inherited Resources speeds up development by making your controllers inherit
# all restful actions so you just have to focus on what is important.
# http://rubygems.org/gems/inherited_resources
# https://github.com/josevalim/inherited_resources
gem "inherited_resources", "~> 1.4.1"

# Search Engine Optimization (SEO) plugin for Ruby on Rails applications
# http://rubygems.org/gems/meta-tags
# https://github.com/kpumuk/meta-tags
gem "meta-tags", "~> 1.5.0", :require => 'meta_tags'

# https://help.github.com/articles/github-flavored-markdown
# use gfm to show articles
gem "github-markdown", "~> 0.6.0"

# http://nokogiri.org
# https://github.com/sparklemotion/nokogiri
# Nokogiri is an HTML, XML, SAX, and Reader parser.
# gem "nokogiri", "~> 1.6.0"

# https://github.com/indirect/jquery-rails
gem "jquery-rails", "~> 3.0.4"

# https://github.com/joliss/jquery-ui-rails
gem "jquery-ui-rails", "~> 4.0.4"

# Haml (HTML Abstraction Markup Language) is a layer on top of HTML or XML
# http://rubygems.org/gems/haml
gem "haml", "~> 4.0.3"

# will_paginate provides a simple API for performing paginated queries with
# Active Record, DataMapper and Sequel
# http://rubygems.org/gems/will_paginate
gem "will_paginate", "~> 3.0.4"

# Squeel unlocks the power of Arel in your Rails 3 application with a handy
# block-based synta
# http://rubygems.org/gems/squeel
gem "squeel", "~> 1.0.18"

# http://github.com/railsjedi/rails_config
gem "rails_config", "~> 0.3.3"

# Twitter Bootstrap CSS (with Sass flavour) and JS toolkits for Rails 3 projects
# http://rubygems.org/gems/anjlab-bootstrap-rails
gem "bootstrap-sass-rails", "~> 3.0.0.2"

# https://github.com/plataformatec/devise
gem "devise", "~> 3.1.1"

# Advanced seed data handling for Rails
# https://github.com/mbleigh/seed-fu
gem "seed-fu", "~> 2.3.0"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'

  # http://rubygems.org/gems/coffee-script
  gem "coffee-script", "~> 2.2.0"
end

group :test, :development do
  gem 'capybara'

  # use thin in development to get ride of "WARN  Could not determine content-length of response body. Set content-length of the response or set Response#chunked = true"
  # A thin and fast web server
  # http://rubygems.org/gems/thin
  gem "thin", "~> 1.5.0" # September 22, 2012

  # gem "better_errors", "~> 0.9.0"
  # http://rubygems.org/gems/better_errors
  gem "better_errors", "~> 0.9.0"

  # Retrieve the binding of a method's caller. Can also retrieve bindings even further up the stack.
  # better_errors use this to display local variables on error pages
  gem "binding_of_caller", "~> 0.7.1" # September 12, 2012

  # https://github.com/rweng/pry-rails
  gem "pry-rails", "~> 0.3.2"

  # https://github.com/nixme/pry-debugger
  gem "pry-debugger", "~> 0.2.2"
end

group :development do
  # http://www.capify.org
  gem "capistrano-ext", "~> 1.2.1"
  # http://rubygems.org/gems/rvm-capistrano
  gem "rvm-capistrano", "~> 1.4.1"
  # http://rubydoc.info/gems/capistrano/2.15.5/frames
  gem "capistrano", "~> 2.15.5"


  # New Relic is a performance management system
  # https://github.com/newrelic/rpm
  gem "newrelic_rpm", "~> 3.6.6.147"

  # http://rubygems.org/gems/rack-mini-profiler
  # Profiling toolkit for Rack applications with Rails integration. Client
  # Side profiling, DB profiling and Server profiling
  gem "rack-mini-profiler", "~> 0.1.27"
end

group :production do
  # https://github.com/brianmario/mysql2
  # gem "mysql2", "~> 0.3.13"
end

# Use unicorn as the app server
# gem 'unicorn'
