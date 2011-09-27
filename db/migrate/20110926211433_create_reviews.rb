class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :details
      t.integer :rating
      t.boolean :is_under_review, :default => false
      t.boolean :is_hidden, :default => false
      t.integer :user_id
      t.references :business

      t.timestamps
    end
    add_index :reviews, :business_id
  end
end
