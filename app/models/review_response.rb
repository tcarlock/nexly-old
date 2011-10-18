class ReviewResponse < ActiveRecord::Base
  belongs_to :review
end

# == Schema Information
#
# Table name: review_responses
#
#  id         :integer(4)      not null, primary key
#  response   :text
#  review_id  :integer(4)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

