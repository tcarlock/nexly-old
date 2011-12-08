if Rails.env == "production" 
   S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "nexly_avatar_prod"} 
 elsif Rails.env == "development" || Rails.env == "demo" || Rails.env == "test"
   S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "nexly_avatar_dev"} 
 elsif Rails.env == "staging"
   S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "nexly_avatar_test"} 
end