class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :details
      t.integer :rating
      t.boolean :is_under_review, :default => false
      t.boolean :is_hidden, :default => false
      t.boolean :is_featured, :default => false
      t.integer :user_id
      t.integer :business_id

      t.timestamps
    end
  end
end
