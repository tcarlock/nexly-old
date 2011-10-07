class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :facebook
      t.string :twitter
      t.string :google_plus
      t.string :linked_in
      t.text :biography
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip_code
      t.column :latitude, :decimal, :precision => 15, :scale => 10
      t.column :longitude, :decimal, :precision => 15, :scale => 10
      t.string :screen_name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
