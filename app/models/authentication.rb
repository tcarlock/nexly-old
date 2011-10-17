class Authentication < ActiveRecord::Base
  belongs_to :platform
  belongs_to :business
end

# == Schema Information
#
# Table name: authentications
#
#  id                   :integer(4)      not null, primary key
#  platform_id          :integer(4)
#  token                :string(255)
#  secret               :string(255)
#  authenticatable_id   :integer(4)
#  authenticatable_type :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

