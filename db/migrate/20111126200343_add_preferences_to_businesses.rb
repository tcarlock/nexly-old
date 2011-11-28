class AddPreferencesToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :preferences, :text
  end
end
