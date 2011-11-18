class PlatformPage < ActiveRecord::Base
  belongs_to :business
  belongs_to :platform
end

# == Schema Information
#
# Table name: platform_pages
#
#  id          :integer(4)      not null, primary key
#  platform_id :integer(4)
#  business_id :integer(4)
#  external_id :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

