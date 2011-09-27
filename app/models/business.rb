class Business < ActiveRecord::Base
  has_many :business_users
  has_many :users, :through => :business_users
  has_many :reviews
  has_many :resources
  
  validates_presence_of :business_name, :biography, :on => :update
  after_validation :geocode
  
  has_attached_file :avatar, 
    :default_url => "/images/profile/anonymous_:style.png", 
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
    self.avatar = nil if self.remove_avatar=="1" && ! 
    self.avatar.dirty? 
    true 
  end
  
  def location
    "#{self.city}, #{self.state}"
  end
  
  def address
    "#{self.address_1}, #{self.address_2} #{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def is_user_admin? user
    self.users.find(user.id) != nil
  end
end

# == Schema Information
#
# Table name: businesses
#
#  id                  :integer(4)      not null, primary key
#  business_id         :integer(4)
#  business_name       :string(255)
#  facebook            :string(255)
#  twitter             :string(255)
#  google_plus         :string(255)
#  linked_in           :string(255)
#  biography           :string(255)
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

