class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :name
      t.string :email
      t.text :message
      t.integer :user_id
      t.integer :business_id

      t.timestamps
    end
  end
end
