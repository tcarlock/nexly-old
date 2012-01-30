require_relative 'social_worker'

class FacebookWallWorker < SocialWorker
	attr_accessor :oauth_token, :name

	merge_gem 'httpclient'
	merge_gem 'attr_required', :require => 'attr_required' 
	merge_gem 'rack-oauth2', :require => 'rack/oauth2'
	merge_gem 'fb_graph'

	def run
		 # Post to feed
    	shorten_link(@link)

		FbGraph::User.me(@oauth_token).feed!(:message => @message, :link => @shortened_url, :name => @name)

	    # Track link in Nexly
	    track_link(@business_id, @shortened_url, @link)
	end
end