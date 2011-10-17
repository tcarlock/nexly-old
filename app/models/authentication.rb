class Authentication < ActiveRecord::Base
  belongs_to :platform
  belongs_to :business
end

# == Schema Information
#
# Table name: authentications
#
#  id          :integer(4)      not null, primary key
#  platform_id :integer(4)
#  uid         :string(255)
#  token       :string(255)
#  secret      :string(255)
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

