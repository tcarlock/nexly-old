class BetaSignup < ActiveRecord::Base
  validates_presence_of :email
end

# == Schema Information
#
# Table name: beta_signups
#
#  id         :integer(4)      not null, primary key
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

