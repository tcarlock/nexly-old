require 'iron_worker'
require 'net/http'
require 'json'
require File.join(File.dirname(__FILE__), 'lib', 'link_helper')

class SocialWorker < IronWorker::Base
	include LinkHelper

	attr_accessor :business_id, :message, :link
end