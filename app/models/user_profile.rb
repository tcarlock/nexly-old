class UserProfile < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :first_name, :last_name, :on => :update
  
  has_attached_file :avatar, 
    :default_url => "/assets/profile/default_user:style.png", 
    :styles => { 
      :large => ["150x150>", :png], 
      :small => ["100x100>", :png], 
      :thumb => ["50x50>", :png]
    }
  
  before_save :perform_avatar_removal 
  
  acts_as_taggable
  acts_as_taggable_on :display_details

  attr_accessor :remove_avatar, :display_details_string, :update_tags
  
  def perform_avatar_removal 
    self.avatar = nil if self.remove_avatar=="1" && ! 
    self.avatar.dirty? 
    true 
  end 
end



# == Schema Information
#
# Table name: user_profiles
#
#  id                  :integer(4)      not null, primary key
#  user_id             :integer(4)
#  first_name          :string(255)
#  last_name           :string(255)
#  facebook            :string(255)
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
#  screen_name         :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer(4)
#  avatar_updated_at   :datetime
#

