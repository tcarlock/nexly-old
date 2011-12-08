# Load the rails application
require File.expand_path('../application', __FILE__)

# Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)

# Initialize the rails application
Nexly::Application.initialize! do |config|
  config.gem "mislav-will_paginate", :lib => "will_paginate", :source => "http://gems.github.com"

  # Initialize mailer and SMTP
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
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
  :stats_date => "%b %Y"
)

WillPaginate.per_page = 7

DOMAIN_NAMES = 
{
  "staging" => "http://nexly-staging.heroku.com", 
  "development" => "http://localhost:3000", 
  "production" =>  "http://nexly.com", 
  "demo" => "http://nexly-demo.heroku.com"
}