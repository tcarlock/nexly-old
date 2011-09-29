class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  has_one :review_response, :as => :response
  
  validates_presence_of :details, :rating
end

# == Schema Information
#
# Table name: reviews
#
#  id              :integer(4)      not null, primary key
#  details         :text
#  rating          :integer(4)
#  is_under_review :boolean(1)      default(FALSE)
#  is_hidden       :boolean(1)      default(FALSE)
#  is_featured     :boolean(1)      default(FALSE)
#  user_id         :integer(4)
#  business_id     :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

