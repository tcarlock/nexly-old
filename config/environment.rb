# Load the rails application
require File.expand_path('../application', __FILE__)

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
  :domain         => ENV['SENDGRID_DOMAIN']
}

Time::DATE_FORMATS.merge!(
  :default => "%b %d at %I:%M%p",
  :feed_date => "%b %d",
  :std_date => "%m/%d/%Y",
  :std_date_time => "%m/%d/%Y at %I:%M%p",
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%m/%d/%Y %H:%M",
)