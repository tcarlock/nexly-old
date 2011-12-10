class RenameLinkTable < ActiveRecord::Migration
  def change
  	rename_table :links, :tracking_links
  end
end
