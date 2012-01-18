require 'iron_worker'

class FacebookFanpageWorker < IronWorker::Base
	attr_accessor :token, :page_id, :message, :link, :name

	merge_gem 'httpclient'
  merge_gem 'attr_required', :require => 'attr_required'
  merge_gem 'rack-oauth2', :require => 'rack/oauth2'
  merge_gem 'fb_graph'

	def run
		page = FbGraph::User.me(token).accounts.detect do |page|
          page.identifier == @page_id
        end

        page.feed!(
          :message => message,
          :link => link, 
          :name => name
        )
	end
end