require 'iron_worker'

class FacebookWallWorker < IronWorker::Base
	attr_accessor :token, :message, :link, :name

	merge_gem 'httpclient'
  	merge_gem 'rack-oauth2'
	merge_gem 'fb_graph'

	def run
		FbGraph::User.me(@token).feed!(:message => @message, :link => @link, :name => @name)
	end
end