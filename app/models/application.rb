class Application < ActiveRecord::Base
  has_many :app_subscriptions
  has_many :businesses, :through => :app_subscriptions
end

# == Schema Information
#
# Table name: applications
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  details    :text
#  price      :float
#  is_public  :boolean(1)      default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

