class ReviewRequest < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  belongs_to :review
  
  before_create :set_token
  
  validates :email, :presence => true, :email_format => true 
  
  def set_token
    self.token = rand(36**8).to_s(36)
  end
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

