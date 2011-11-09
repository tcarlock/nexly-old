require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: links
#
#  id          :integer(4)      not null, primary key
#  business_id :integer(4)
#  in_url      :string(255)
#  out_url     :text
#  http_status :integer(4)      default(301)
#  created_at  :datetime
#  updated_at  :datetime
#

