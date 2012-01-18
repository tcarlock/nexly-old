require 'iron_worker'

class LinkedInWorker < IronWorker::Base
	attr_accessor :token, :secret, :message

	merge_gem "linkedin", :branch => "2-0-stable"

	def run
		li_user = LinkedIn::Client.new("694wVPqtdE2lQmrRRJ2YG-uxoVA-f1E6Cb6cPUdxe2xUMcwuaq4D0wgmcdwAoucg", "0tY-2DGwi0w1MbtitnV1I9PIjdOUqyDoVSNxWspucm0ZfziRJmAxHB_Dqwi1m_zM")
        li_user.authorize_from_access(@token, @secret)

		li_user.add_share(:comment => @message)
	end
end