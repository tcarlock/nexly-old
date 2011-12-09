class Recommendation < ActiveRecord::Base
	belongs_to :business
	
	validates_presence_of :name, :email, :message => "Required field", 
end

# == Schema Information
#
# Table name: recommendations
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  email       :string(255)
#  message     :text
#  user_id     :integer(4)
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

