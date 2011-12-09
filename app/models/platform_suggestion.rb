class PlatformSuggestion < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :url, :message => ""
  validates :url, :uri_format => true

  before_validation :sanitize_url

  def sanitize_url
    if !self.url.empty?
    	unless self.url.include?("http://") || self.url.include?("https://")
          self.url = "http://" + self.url
		end
    end
  end
end

# == Schema Information
#
# Table name: platform_suggestions
#
#  id         :integer(4)      not null, primary key
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

