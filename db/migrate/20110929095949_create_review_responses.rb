class CreateReviewResponses < ActiveRecord::Migration
  def change
    create_table :review_responses do |t|
      t.text :response
      t.integer :review_id
      t.integer :user_id

      t.timestamps
    end
  end
end
