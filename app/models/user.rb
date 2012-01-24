class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  has_one :profile, :class_name => "UserProfile", :dependent => :destroy
  has_one :business_user
  has_one :business, :through => :business_user
  
  validates :email, :presence => true, :uniqueness => true, :email_format => true 
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :profile_attributes, :email, :password, :password_confirmation, :remember_me
  accepts_nested_attributes_for :profile
           
  # after_create :setup_blank_profile
  
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
  
  # def business
  #   self.businesses.first
  # end
  
  def authentications
    self.businesses.first.authentications
  end
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
      when 'facebook'
        self.apply_facebook(omniauth)
      when 'twitter'
        self.apply_twitter(omniauth)
      when 'linked_in'
        self.apply_lnkedin(omniauth)
    end
    authentications.build(hash_from_omniauth(omniauth))
  end

  def facebook
    if @fb_user.nil?   # Not initialized yet
      auth = get_auth("facebook")

      unless auth.nil?
        @fb_user = FbGraph::User.me(auth.token)
      end
    end

    @fb_user
  end

  def linkedin
    if @li_user.nil?   # Not initialized yet
      auth = get_auth("linked_in")

      unless auth.nil?
        @li_user = LinkedIn::Client.new("694wVPqtdE2lQmrRRJ2YG-uxoVA-f1E6Cb6cPUdxe2xUMcwuaq4D0wgmcdwAoucg", "0tY-2DGwi0w1MbtitnV1I9PIjdOUqyDoVSNxWspucm0ZfziRJmAxHB_Dqwi1m_zM")
        @li_user.authorize_from_access(auth.token, auth.secret)
      end
    end

    @li_user
  end
  
  def twitter
    if @twitter_user.nil?   # Not initialized yet
     auth = get_auth("twitter")

      unless auth.nil?
        @twitter_user = Twitter::Client.new(:oauth_token => auth.token, :oauth_token_secret => auth.secret) rescue nil
      end
    end

    @twitter_user
  end
  
  private

  def get_auth platform_name
    platform_id = Platform.find_by_name(platform_name).id
    self.authentications.find_by_platform_id(platform_id)
  end
  
  def setup_blank_profile
    if self.profile.blank?
      UserProfile.create!(:user => self)
    end
  end
  
  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
  
  def apply_linkedin(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end
  
  def apply_twitter(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      # Example fetching extra data. Needs migration to User model:
      # self.firstname = (extra['name'] rescue '')
    end
  end

  def hash_from_omniauth(omniauth)
    {
      :provider => omniauth['provider'], 
      :uid => omniauth['uid'], 
      :token => (omniauth['credentials']['token'] rescue nil),
      :secret => (omniauth['credentials']['secret'] rescue nil)
    }
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

