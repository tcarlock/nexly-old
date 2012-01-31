require 'iron_worker'
require 'net/http'
require 'json'
# require_relative 'link_helper'

class SocialWorker < IronWorker::Base
	# include LinkHelper

	attr_accessor :business_id, :message, :link, :link_tracking_url, :bitly_api_key, :shortened_url

	def shorten_link url
		# log 'Shortening URL: ' + url
		user = 'nexly'
	    bitly_url = URI("http://api.bitly.com/v3/shorten/?login=#{user}&apiKey=#{@bitly_api_key}&longUrl=#{CGI::escape(url)}&format=json")

	    @shortened_url = JSON.parse(Net::HTTP.get(bitly_url))['data']['url']
	    # log 'URL shortened to: ' + @shortened_url

	    @shortened_url
	end

	def track_link business_id, in_url, out_url
		# log 'Logging links to ' + @link_tracking_url + ' ' + in_url + ' | ' + out_url

		Net::HTTP.post_form(URI.parse(@link_tracking_url), { :business_id => business_id, :in_url => in_url, :out_url => out_url })
	end
end