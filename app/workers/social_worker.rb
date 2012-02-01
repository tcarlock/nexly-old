require 'iron_worker'
require 'net/http'
require 'json'

merge '../../lib/link_helper.rb'

class SocialWorker < IronWorker::Base
	include LinkHelper

	attr_accessor :business_id, :message, :link
end