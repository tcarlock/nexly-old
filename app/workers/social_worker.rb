require 'iron_worker'
require 'net/http'
require 'json'
require_relative 'link_helper'

class SocialWorker < IronWorker::Base
	include LinkHelper

	attr_accessor :business_id, :message, :link
end