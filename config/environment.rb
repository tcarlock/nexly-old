# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Nexly::Application.initialize! do |config|
  config.gem "mislav-will_paginate", :lib => "will_paginate", :source => "http://gems.github.com"
end

Time::DATE_FORMATS.merge!(
  :default => "%b %d at %I:%M%p",
  :feed_date => "%b %d",
  :std_date => "%m/%d/%Y",
  :std_date_time => "%m/%d/%Y at %I:%M%p",
  :date_time12  => "%m/%d/%Y %I:%M%p",
  :date_time24  => "%m/%d/%Y %H:%M",
)