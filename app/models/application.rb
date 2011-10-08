class Application < ActiveRecord::Base
  has_many :app_subscriptions
  has_many :businesses, :through => :app_subscriptions
end
