class Business < ActiveRecord::Base
  # Associations
  has_many :business_users
  has_many :users, :through => :business_users
  
  has_many :app_subscriptions
  has_many :applications, :through => :app_subscriptions
  
  has_many :authentications
  has_many :active_platforms, :source => :platform, :foreign_key => "platform_id", :through => :authentications
    
  has_many :recommendations
  has_many :reviews
  has_many :review_requests
  has_many :pending_reviews, :class_name => "Review", :foreign_key => "business_id", :conditions => ['is_approved = ? AND is_rejected = ?', false, false]
  has_many :approved_reviews, :class_name => "Review", :foreign_key => "business_id", :conditions => ['is_approved = ?', true]
  has_many :rejected_reviews, :class_name => "Review", :foreign_key => "business_id", :conditions => ['is_rejected = ?', true]
  has_many :pending_review_requests, :class_name => "ReviewRequest", :foreign_key => "business_id", :conditions => ['is_reviewed = ?', false]
  has_many :resources
  
  has_many :links
  has_many :page_views
  
  # Sphinx indexes
  # define_index do
  #   indexes :name, :sortable => true
  #   indexes biography
  #   indexes city
  #   indexes state
  #   indexes zip_code
  # end
  
  # Validations
  validates_presence_of :name, :biography, :address_1, :city, :state, :zip_code, :website, :on => :update
  validates :website, :presence => true, :uri_format => true 
    
  after_validation :geocode
  before_create :set_api_token
  
  has_attached_file :avatar,
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "/:style/:id/:filename",
    :default_url => "/assets/avatars/default_biz_:style.gif", 
    :styles => { 
      :large => ["150x150>", :png], 
      :small => ["100x100>", :png], 
      :thumb => ["50x50>", :png]
    }
  
  acts_as_taggable
  acts_as_taggable_on :capabilities
  
  geocoded_by :address

  attr_accessor :remove_avatar, :capabilities_string, :update_tags
  
  before_save :perform_avatar_removal
  
  def perform_avatar_removal 
    self.avatar = nil if self.remove_avatar=="1" && !self.avatar.dirty? 
    true 
  end
  
  preferable do
    boolean :is_toolbar_active, :default => false
    boolean :is_reviewing_enabled, :default => false
    boolean :is_recs_enabled, :default => false
  end
    
  def location
    "#{self.city}, #{self.state}"
  end
  
  def address
    "#{self.address_1}, #{self.address_2} #{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def review_stats
    if self.reviews.count > 0
      ReviewStats.new(self.id)
    end
  end
  
  def traffic_browser start_date = 365.days.ago.beginning_of_month, end_date = DateTime.current.beginning_of_month
    @browser = TrafficDetails.new(self.id, start_date, end_date)
    @browser
  end
  
  def is_user_admin? user
    !self.users.find_by_id(user.id).nil?
  end
  
  private
  
  def set_api_token
    self.api_token = rand(36**8).to_s(36)
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
#  api_token           :string(255)
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
#  phone               :string(255)
#

