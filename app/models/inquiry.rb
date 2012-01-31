class Inquiry < ActiveRecord::Base
	belongs_to :business
	
	validates_presence_of :first_name, :last_name, :details
	validates :email, :presence => true, :email_format => true

	def display_name
		(self.first_name || '') << ' ' << (self.last_name || '')
	end
end

# == Schema Information
#
# Table name: inquiries
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  email       :string(255)
#  details     :text
#  business_id :integer(4)
#  is_archived :boolean(1)      default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

