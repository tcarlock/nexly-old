require 'iron_worker'
require 'httparty'

class SocialWorker < IronWorker::Base
	include LinkHelper

	attr_accessor :message, :link

	merge_gem 'httparty'
end