class RenameLinkTable < ActiveRecord::Migration
  def change
  	rename_table :link, :tracking_link
  end
end
