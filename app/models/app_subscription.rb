class AppSubscription < ActiveRecord::Base
  belongs_to :business
  belongs_to :application
end

# == Schema Information
#
# Table name: app_subscriptions
#
#  id             :integer(4)      not null, primary key
#  application_id :integer(4)
#  business_id    :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

