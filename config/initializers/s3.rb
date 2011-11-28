if Rails.env == "production" 
   S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "nexly_avatar_prod"} 
 elsif Rails.env == "development"
   S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "nexly_avatar_dev"} 
 elsif Rails.env == "test"
   S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => "nexly_avatar_test"} 
end