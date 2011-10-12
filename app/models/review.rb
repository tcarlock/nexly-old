class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  has_one :review_response, :as => :response
  
  validates_presence_of :details, :rating
  validates_numericality_of :rating, :only_integer => true, :message => "Must be a whole number"
  validates_inclusion_of :rating, :in => 0..5, :message => "Must be from 0 to 5"
end

# == Schema Information
#
# Table name: reviews
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  email           :string(255)
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

