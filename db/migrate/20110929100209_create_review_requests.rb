class CreateReviewRequests < ActiveRecord::Migration
  def change
    create_table :review_requests do |t|
      t.string :email
      t.test :message
      t.string :token
      t.boolean :is_reviewed
      t.integer :business_id
      t.integer :user_id

      t.timestamps
    end
  end
end
