class Business < ActiveRecord::Base
  has_many :business_users
  has_many :users, :through => :business_users
  
  has_many :app_subscriptions
  has_many :applications, :through => :app_subscriptions
  has_many :authentications
    
  has_many :recommendations
  has_many :reviews
  has_many :review_requests
  has_many :pending_reviews, :class_name => "Review", :foreign_key => "business_id", :conditions => ['is_approved = ? && is_rejected = ?', false, false]
  has_many :approved_reviews, :class_name => "Review", :foreign_key => "business_id", :conditions => ['is_approved = ?', true]
  has_many :rejected_reviews, :class_name => "Review", :foreign_key => "business_id", :conditions => ['is_rejected = ?', true]
  has_many :pending_review_requests, :class_name => "ReviewRequest", :foreign_key => "business_id", :conditions => ['is_reviewed = ?', false]
  has_many :resources
  
  validates_presence_of :name, :biography, :address_1, :city, :state, :zip_code, :on => :update
  after_validation :geocode
  
  has_attached_file :avatar, 
    :default_url => "/assets/profile/anon_user_:style.png", 
    :styles => { 
      :large => ["150x150>", :png], 
      :small => ["100x100>", :png], 
      :thumb => ["50x50>", :png]
    }
  
  before_save :perform_avatar_removal 
  
  acts_as_taggable
  acts_as_taggable_on :capabilities
  
  geocoded_by :address

  attr_accessor :remove_avatar, :capabilities_string, :update_tags
  
  def perform_avatar_removal 
    self.avatar = nil if self.remove_avatar=="1" && !self.avatar.dirty? 
    true 
  end
  
  def location
    "#{self.city}, #{self.state}"
  end
  
  def address
    "#{self.address_1}, #{self.address_2} #{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def review_stats
    if self.reviews.count > 1
      ReviewStats.new(self.id)
    end
  end
  
  def is_user_admin? user
    self.users.find(user.id) != nil
  end
end

class ReviewStats
  def initialize id
    @business = Business.find(id)
  end
  
  def total_review_count
    @business.reviews.count
  end
  
  def pending_review_count
    @business.pending_reviews.count
  end
  
  def approved_review_count
    @business.approved_reviews.count
  end
  
  def rejected_review_count
    @business.rejected_reviews.count
  end
  
  def pending_request_count
    @business.pending_review_requests.count
  end
  
  def average_rating
    Review.average(:rating, :conditions => ["business_id = ?", @business.id])
  end
  
  def min_rating
  end
  
  def max_rating
  end
  
  def submission_rate
    if @business.review_requests.count == 0
      0.0 / 0.0
    else
      (@business.review_requests.count - @business.active_review_requests) / @business.review_requests.count
    end
  end
end

# == Schema Information
#
# Table name: businesses
#
#  id                  :integer(4)      not null, primary key
#  name                :string(255)
#  facebook            :string(255)
#  website             :string(255)
#  twitter             :string(255)
#  google_plus         :string(255)
#  linked_in           :string(255)
#  biography           :text
#  address_1           :string(255)
#  address_2           :string(255)
#  city                :string(255)
#  state               :string(255)
#  zip_code            :string(255)
#  latitude            :decimal(15, 10)
#  longitude           :decimal(15, 10)
#  industry_id         :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#

