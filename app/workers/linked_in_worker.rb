require_relative 'social_worker'

class LinkedInWorker < SocialWorker
	attr_accessor :oauth_token, :oauth_secret, :consumer_key, :consumer_secret

	merge_gem "linkedin", :branch => "2-0-stable"

	def run
		# Post update
		shorten_link(@link)

		li_user = LinkedIn::Client.new(@consumer_key, @consumer_secret)
        li_user.authorize_from_access(@oauth_token, @oauth_secret)

		li_user.add_share(:comment => @message + " " + @shortened_url)

		# Track link in Nexly
		track_link(@business_id, @shortened_url, @link)
	end
end