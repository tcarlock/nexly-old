class TrackingLink < ActiveRecord::Base
  belongs_to :business
  
  validates :in_url, :out_url, :http_status, :presence => true
  validates :in_url, :uniqueness => true
end

# == Schema Information
#
# Table name: tracking_links
#
#  id          :integer(4)      not null, primary key
#  business_id :integer(4)
#  in_url      :string(255)
#  out_url     :text
#  http_status :integer(4)      default(301)
#  created_at  :datetime
#  updated_at  :datetime
#

