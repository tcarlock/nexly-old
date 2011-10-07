class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :email
      t.text :details
      t.integer :rating
      t.boolean :is_under_review, :default => false
      t.boolean :is_approved, :default => false
      t.boolean :is_approved, :default => false
      t.integer :user_id
      t.integer :business_id
      t.boolean :is_anon, :default => false

      t.timestamps
    end
  end
end
