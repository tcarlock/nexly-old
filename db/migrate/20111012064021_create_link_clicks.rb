class CreateLinkClicks < ActiveRecord::Migration
  def change
    create_table :link_clicks do |t|
      t.string :referrer_domain
      t.string :url
      t.integer :business_id
      t.integer :reference_id
      t.integer :link_type_id

      t.timestamps
    end
    add_index :link_clicks, [:url, :referrer_domain]
  end
end
