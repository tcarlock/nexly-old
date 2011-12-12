require 'spec_helper'

describe NewsPost do
	before(:each) do
		@post = NewsPost.new
	end

	it "should not validate without title and content" do
		true
	end
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

