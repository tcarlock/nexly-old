class CreateBusinesses < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string :name
      t.string :facebook
      t.string :website
      t.string :twitter
      t.string :google_plus
      t.string :linked_in
      t.string :api_token
      t.text :biography
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip_code
      t.column :latitude, :decimal, :precision => 15, :scale => 10
      t.column :longitude, :decimal, :precision => 15, :scale => 10
      t.integer :industry_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
