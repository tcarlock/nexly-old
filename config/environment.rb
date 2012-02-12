# Load the rails application
require File.expand_path('../application', __FILE__)

# Load ENV vars from local file
env_vars = File.join(Rails.root, 'config', 'env_vars.rb')
load(env_vars) if File.exists?(env_vars)

# Initialize the rails application
Nexly::Application.initialize! do |config|
  config.gem "mislav-will_paginate", :lib => "will_paginate", :source => "http://gems.github.com"

  # Initialize mailer and SMTP
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true

  config.load_paths += %W( #{RAILS_ROOT}/app/workers )
end

ActionMailer::Base.smtp_settings = {
  :address        => "smtp.sendgrid.net",
  :port           => "25",
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => "nexly.com"
}

Time::DATE_FORMATS.merge!(
  :default => "%b %d at %I:%M%p",
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%m/%d/%Y %H:%M",
  :date_only  => "%m/%d/%Y",
  :feed_date => "%b %d",
  :feed_date_year => "%b %d, %Y",
  :feed_date_time => "%b %d at %I:%M%p",
  :stats_date => "%b %d, %Y"
)

WillPaginate.per_page = 7

DOMAIN_NAMES = 
{
  "staging" => "http://nexly-staging.herokuapp.com", 
  "development" => "http://127.0.0.1:3000", 
  "production" =>  "http://nexly.com", 
  "demo" => "http://nexly-demo.herokuapp.com"
}