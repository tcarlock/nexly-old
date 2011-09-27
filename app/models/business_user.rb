class BusinessUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
end

# == Schema Information
#
# Table name: business_users
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

