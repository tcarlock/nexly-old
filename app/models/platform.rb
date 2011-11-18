class Platform < ActiveRecord::Base
  has_many :authentications
  has_many :page_views
  has_many :platform_pages
end

# == Schema Information
#
# Table name: platforms
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  icon          :string(255)
#  display_order :integer(4)
#  details       :string(255)
#  is_available  :boolean(1)      default(TRUE)
#  display_name  :string(255)
#

