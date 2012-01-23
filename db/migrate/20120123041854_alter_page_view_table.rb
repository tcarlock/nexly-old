class AlterPageViewTable < ActiveRecord::Migration
  def change
  	rename_column :page_views, :link_type_id, :resource_type_id
  	rename_column :page_views, :reference_id, :resource_id
  	add_column :page_views, :channel_type_id, :integer
  end
end
