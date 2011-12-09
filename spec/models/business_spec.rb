require 'spec_helper'

describe Business do
	before(:each) do
		@biz = Business.new
	end

	it "should not validate without required fields" do

	end

  it "should not validate with poorly formed URLs" do

  end

  it "should normalize all URLs to include http or https" do

  end

  it "should automatically set an API token before creation" do

  end

  it "should automatically set an API token" do

  end

  it "should automatically init preferences with a default value of false" do

  end
end

# == Schema Information
#
# Table name: businesses
#
#  id                  :integer(4)      not null, primary key
#  name                :string(255)
#  facebook            :string(255)
#  website             :string(255)
#  twitter             :string(255)
#  google_plus         :string(255)
#  linked_in           :string(255)
#  api_token           :string(255)
#  biography           :text
#  address_1           :string(255)
#  address_2           :string(255)
#  city                :string(255)
#  state               :string(255)
#  zip_code            :string(255)
#  latitude            :decimal(15, 10)
#  longitude           :decimal(15, 10)
#  industry_id         :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#  phone               :string(255)
#  preferences         :text
#

