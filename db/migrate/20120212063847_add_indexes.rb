class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :user_profiles, :user_id
  	add_index :reviews, :business_id
  	add_index :review_requests, :business_id
  	add_index :inquiries, :business_id
  	add_index :recommendations, :business_id
  	add_index :tracking_links, :business_id
  	add_index :page_views, [:resource_id, :business_id, :platform_id, :resource_type_id, :channel_type_id], :name => 'index_page_views_multi_col'
  	add_index :platform_pages, [:external_id, :business_id, :platform_id], :name => 'index_platform_pages_multi_col'
  	add_index :authentications, [:business_id, :platform_id]
  end
end
