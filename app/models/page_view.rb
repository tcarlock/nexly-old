class PageView < ActiveRecord::Base
  belongs_to :business
  belongs_to :platform
  
  validates_presence_of :url
  validates_numericality_of :business_id, :resource_type_id, :greater_than => 0
end
# == Schema Information
#
# Table name: page_views
#
#  id               :integer(4)      not null, primary key
#  url              :text
#  business_id      :integer(4)
#  resource_id      :integer(4)
#  resource_type_id :integer(4)
#  platform_id      :integer(4)
#  created_at       :datetime
#  updated_at       :datetime
#  ip_address       :string(255)
#  channel_type_id  :integer(4)
#

