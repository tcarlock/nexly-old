require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: reviews
#
#  id              :integer(4)      not null, primary key
#  name            :text
#  email           :text
#  details         :text
#  rating          :integer(4)
#  is_under_review :boolean(1)      default(FALSE)
#  is_approved     :boolean(1)      default(FALSE)
#  user_id         :integer(4)
#  business_id     :integer(4)
#  is_anon         :boolean(1)      default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

