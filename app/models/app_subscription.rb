class AppSubscription < ActiveRecord::Base
  belongs_to :business
  belongs_to :application
end
