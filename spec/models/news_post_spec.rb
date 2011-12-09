require 'spec_helper'

describe NewsPost do
	before(:each) do
		@post = NewsPost.new
	end

	it "should not validate without title and content" do
		true
	end
end
