class PlatformSuggestion < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :url, :message => ""
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

