require 'iron_worker'
require 'httparty'

class SocialWorker < IronWorker::Base
	attr_accessor :link_tracking_url, :bitly_api_key, :shortened_url

	merge_gem 'httparty'

	def shorten_link url
		log 'Shortening URL: ' + url

		user = 'nexly'
	    bitly_url = "http://api.bitly.com/v3/shorten/?login=#{user}&apiKey=#{@bitly_api_key}&longUrl=#{CGI::escape(url)}&format=json"
	    
	    # buffer = open(bitly_url, 'UserAgent' => 'Ruby-ExpandLink').read
	    @shortened_url = HTTParty.get(bitly_url)['data']['url']   # JSON.parse(buffer)['data']['url']

	    log 'URL shortened to: ' + @shortened_url

	    @shortened_url
	end

	def track_link in_url, out_url
		log 'Logging links to ' + @link_tracking_url + ' ' + in_url + ' | ' + out_url

		resp = HTTParty.post(@link_tracking_url, {:body => { :in_url => in_url, :out_url => out_url }})
    	p resp
	end
end