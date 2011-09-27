class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_one :profile, :class_name => "UserProfile", :dependent => :destroy
  
  has_many :business_users
  has_many :businesses, :through => :business_users
           
  after_create :setup_blank_profile
  
  def setup_blank_profile
    if self.profile.blank?
      p = UserProfile.create(:user => self)
      p.save
    end
  end
  
  def screenname
    self.profile.screen_name
  end
  
  def display_name
    if self.profile.first_name.nil? && self.profile.last_name.nil?
      self.email
    else
      "#{self.profile.first_name} #{self.profile.last_name}"
    end
  end
  
  def location
    "#{self.profile.city}, #{self.profile.state}"
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean(1)      default(FALSE)
#

