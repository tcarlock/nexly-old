class Recommendation < ActiveRecord::Base
end

# == Schema Information
#
# Table name: recommendations
#
#  id          :integer(4)      not null, primary key
#  email       :string(255)
#  message     :text
#  user_id     :integer(4)
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

