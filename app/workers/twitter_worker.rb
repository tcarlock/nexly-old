require_relative 'social_worker'

class TwitterWorker < SocialWorker
	attr_accessor :oauth_token, :oauth_secret, :consumer_key, :consumer_secret

	merge_gem 'addressable', :require => 'addressable/uri'
	merge_gem 'multipart-post', :require => 'multipart_post'
	merge_gem 'faraday'
	merge_gem 'simple_oauth'
	merge_gem 'twitter'

	def run
		# Process for 140 char count limit taking into account shortened link length
    short_link_len = 20
    sep_text = '...'
    max_msg_len = (140 - short_link_len - (sep_text.length + 1))
    
    # Return message shortened by length of Twitter's converted links (19 chars) to fit 140 char limitation
    if @message.length > max_msg_len
      short_split = @message[0..max_msg_len].split()
      tweet_text = short_split[0, short_split.length - 1].join(' ') + sep_text
    else
    	tweet_text = @message
    end

		# Post tweet
		Twitter.configure do |x|
      x.consumer_key       = @consumer_key
      x.consumer_secret    = @consumer_secret
      x.oauth_token        = @oauth_token
      x.oauth_token_secret = @oauth_secret
    end

    shorten_link(@link)

		Twitter.update(tweet_text + ' ' + @shortened_url)

		# Track link in Nexly
		track_link(@business_id, @shortened_url, @link)
	end
end