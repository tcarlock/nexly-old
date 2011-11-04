class RebuildPageViews < ActiveRecord::Migration
  def up
    drop_table :page_views
    
    create_table :page_views do |t|
      t.text :url
      t.integer :business_id
      t.integer :reference_id
      t.integer :link_type_id
      t.integer :platform_id

      t.timestamps
    end
  end
end
