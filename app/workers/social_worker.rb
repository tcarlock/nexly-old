require 'iron_worker'
require 'net/http'
require 'json'

class SocialWorker < IronWorker::Base
	merge '../lib/link_helper'
	
	include LinkHelper

	attr_accessor :business_id, :message, :link
end