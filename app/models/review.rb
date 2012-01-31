class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  has_one :review_request
  has_one :review_response
  
  validates_presence_of :first_name, :last_name, :details, :rating
  validates :email, :presence => true, :email_format => true
  validates_numericality_of :rating, :only_integer => true, :message => "Must be a whole number"
  validates_inclusion_of :rating, :in => 1..5, :message => "Must be from 1 to 5"
  
  has_attached_file :avatar, 
  :storage => :s3,
  :s3_credentials => S3_CREDENTIALS,
  :path => "/:style/:id/:filename",
    :default_url => "/assets/avatars/default_user_:style.gif", 
    :styles => { 
      :thumb => ["50x50>", :png],
      :tab => ["25x25>", :png]
    }
  
  def display_name
    (self.first_name || '') << ' ' << (self.last_name || '')
  end
end

# == Schema Information
#
# Table name: reviews
#
#  id                  :integer(4)      not null, primary key
#  name                :string(255)
#  email               :string(255)
#  details             :text
#  rating              :integer(4)
#  is_under_review     :boolean(1)      default(FALSE)
#  is_approved         :boolean(1)      default(FALSE)
#  is_rejected         :boolean(1)      default(FALSE)
#  business_id         :integer(4)
#  is_anon             :boolean(1)      default(FALSE)
#  created_at          :datetime
#  updated_at          :datetime
#  review_request_id   :integer(4)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#

