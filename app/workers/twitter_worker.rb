require 'iron_worker'

class TwitterWorker < IronWorker::Base
	attr_accessor :token, :secret, :message

	merge_gem 'twitter'

	def run
		Twitter::Client.new(:oauth_token => token, :oauth_token_secret => secret).update(message)
	end
end