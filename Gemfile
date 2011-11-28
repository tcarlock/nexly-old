source "http://rubygems.org"

gem "rails", "3.1.0"

# Bundle edge Rails instead:
# gem "rails",     :git => "git://github.com/rails/rails.git"

gem "mysql2"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails", "  ~> 3.1.0"
  gem "coffee-rails", "~> 3.1.0"
  gem "uglifier"
end

gem "aws-s3"
gem "formtastic", "=1.2.4"
gem "client_side_validations", "~> 3.0.11"
gem "devise"
gem "paperclip", "~> 2.3.15"
gem "acts-as-taggable-on"
gem "jquery-rails"
gem "geocoder"
gem "will_paginate", "~> 3.0.pre4"
gem "omniauth"
gem "twitter", "~> 1.0"
gem "fb_graph"
gem "linkedin", :branch => "2-0-stable"
gem "faker", "~> 1.0.1"
gem "preferable"
# gem "thinking-sphinx"

# Use unicorn as the web server
# gem "unicorn"

# Deploy with Capistrano
# gem "capistrano"

# To use debugger
# gem "ruby-debug19", :require => "ruby-debug"

group :development, :test do
  gem "rspec-rails", ">= 2.0.0.beta"
  gem "autotest"
  gem "autotest-rails"

  gem "ruby-debug19", :require => "ruby-debug"
  gem "turn", :require => false
  gem "annotate", :git => "git://github.com/jeremyolliver/annotate_models.git", :branch => "rake_compatibility"
  gem "heroku_san" 
end

group :production do
  # gems specifically for Heroku go here
  gem "pg"
  # gem "flying-sphinx"
end

