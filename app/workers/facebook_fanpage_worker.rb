require 'social_worker'

class FacebookFanpageWorker < SocialWorker
	attr_accessor :oauth_token, :page_id, :message, :link, :name

	merge_gem 'httpclient'
    merge_gem 'attr_required', :require => 'attr_required'
    merge_gem 'rack-oauth2', :require => 'rack/oauth2'
    merge_gem 'fb_graph'

	def run
    # Post to feed
    shorten_link(@link)

  	page = FbGraph::User.me(@oauth_token).accounts.detect do |page|
      page.identifier == @page_id
    end

    page.feed!(:message => @message, :link => @shortened_url, :name => @name)

    # Track link in Nexly
    track_link(@link, @shortened_url)
	end
end