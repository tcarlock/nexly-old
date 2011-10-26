class PageView < ActiveRecord::Base
  belongs_to :business
  belongs_to :platform
  
  def self.types
    {:profile  => 1, :review => 2}
  end
  
  validates_presence_of :url
  validates_numericality_of :business_id, :link_type_id, :greater_than => 0
end

# == Schema Information
#
# Table name: page_views
#
#  id           :integer(4)      not null, primary key
#  url          :string(255)
#  business_id  :integer(4)
#  reference_id :integer(4)
#  link_type_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  platform_id  :integer(4)
#

