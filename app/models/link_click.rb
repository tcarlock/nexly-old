class LinkClick < ActiveRecord::Base
  def self.types
    {:profile  => 1, :review => 2}
  end
  
  validates_presence_of :referrer_domain, :url
  validates_numericality_of :business_id, :link_type_id, :greater_than => 0
end

# == Schema Information
#
# Table name: link_clicks
#
#  id              :integer(4)      not null, primary key
#  referrer_domain :string(255)
#  url             :string(255)
#  business_id     :integer(4)
#  reference_id    :integer(4)
#  link_type_id    :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

