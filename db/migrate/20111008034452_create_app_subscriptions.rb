class CreateAppSubscriptions < ActiveRecord::Migration
  def change
    create_table :app_subscriptions do |t|
      t.integer :application_id
      t.integer :business_id

      t.timestamps
    end
  end
end
