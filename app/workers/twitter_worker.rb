require 'iron_worker'

class TwitterWorker < IronWorker::Base
	attr_accessor :oauth_token, :oauth_secret, :consumer_key, :consumer_secret, :message

	merge_gem 'addressable', :require => 'addressable/uri'
	merge_gem 'multipart-post', :require => 'multipart_post'
	merge_gem 'faraday'
	merge_gem 'simple_oauth'
	merge_gem 'twitter'

	def run
		Twitter.configure do |x|
	      x.consumer_key       = @consumer_key
	      x.consumer_secret    = @consumer_secret
	      x.oauth_token        = @oauth_token
	      x.oauth_token_secret = @oauth_secret
	    end

		Twitter.update(@message)
	end
end