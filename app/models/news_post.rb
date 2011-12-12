class NewsPost < ActiveRecord::Base
	belongs_to :business

	validates_presence_of :title, :content, :message => "Required field", 
end

# == Schema Information
#
# Table name: news_posts
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  content     :text
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

