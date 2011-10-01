class CreateReviewRequests < ActiveRecord::Migration
  def change
    create_table :review_requests do |t|
      t.string :name
      t.string :email
      t.text :message
      t.string :token
      t.boolean :is_reviewed, :default => false
      t.integer :business_id
      t.integer :user_id

      t.timestamps
    end
  end
end
