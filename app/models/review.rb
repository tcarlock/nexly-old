class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  
  validates_presence_of :details, :rating
end

# == Schema Information
#
# Table name: reviews
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  details     :text
#  rating      :integer(4)
#  user_id     :integer(4)
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

