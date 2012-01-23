module LinkHelper
	attr_accessor :link_tracking_url, :bitly_api_key, :shortened_url
	
	def shorten_link url
		log 'Shortening URL: ' + url

		user = 'nexly'
	    bitly_url = "http://api.bitly.com/v3/shorten/?login=#{user}&apiKey=#{@bitly_api_key}&longUrl=#{CGI::escape(url)}&format=json"
	    
	    @shortened_url = HTTParty.get(bitly_url)['data']['url']

	    log 'URL shortened to: ' + @shortened_url

	    @shortened_url
	end

	def track_link in_url, out_url
		log 'Logging links to ' + @link_tracking_url + ' ' + in_url + ' | ' + out_url

		resp = HTTParty.post(@link_tracking_url, {:body => { :in_url => in_url, :out_url => out_url }})
    	p resp
	end
end