require 'iron_worker'
require 'net/http'
require 'json'

class SocialWorker < IronWorker::Base
	include LinkHelper

	merge '../../lib/link_helper.rb'

	attr_accessor :business_id, :message, :link
end