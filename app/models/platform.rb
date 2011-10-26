class Platform < ActiveRecord::Base
  has_many :authentications
  has_many :page_views
end

# == Schema Information
#
# Table name: platforms
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

