require 'test_helper'

class PageViewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: page_views
#
#  id               :integer(4)      not null, primary key
#  url              :text
#  business_id      :integer(4)
#  resource_id      :integer(4)
#  resource_type_id :integer(4)
#  platform_id      :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#  ip_address       :string(255)
#  channel_type_id  :integer(4)
#

