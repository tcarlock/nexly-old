class AlterLinkClickTable < ActiveRecord::Migration
  def up
    add_column :link_clicks, :platform_id, :integer
    remove_column :link_clicks, :referrer_domain
    rename_table :link_clicks, :page_views
  end

  def down
    rename_table :page_views, :link_clicks
    remove_column :link_clicks, :platform_id
  end
end
