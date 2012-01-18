require 'iron_worker'

class TwitterWorker < IronWorker::Base
	attr_accessor :token, :secret, :message

	merge_gem 'addressable', :require => 'addressable/uri'
	merge_gem 'multipart-post', :require => 'multipart_post'
	merge_gem 'faraday'
	merge_gem 'simple_oauth'
	merge_gem 'twitter'

	def run
		Twitter::Client.new(:oauth_token => token, :oauth_token_secret => secret).update(message)
	end
end