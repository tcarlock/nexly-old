require 'test_helper'

class ReviewRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: review_requests
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  email       :string(255)
#  message     :text
#  token       :string(255)
#  is_reviewed :boolean(1)      default(FALSE)
#  business_id :integer(4)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

