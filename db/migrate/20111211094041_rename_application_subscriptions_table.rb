class RenameApplicationSubscriptionsTable < ActiveRecord::Migration
  def change
  	rename_table :app_subscriptions, :feature_subscriptions
  	rename_column :feature_subscriptions, :application_id, :feature_id
  end
end
