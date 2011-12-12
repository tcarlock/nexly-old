class FeatureSubscription < ActiveRecord::Base
  belongs_to :business
  belongs_to :feature
end

# == Schema Information
#
# Table name: feature_subscriptions
#
#  id          :integer(4)      not null, primary key
#  feature_id  :integer(4)
#  business_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

