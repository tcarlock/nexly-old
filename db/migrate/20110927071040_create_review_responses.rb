class CreateReviewResponses < ActiveRecord::Migration
  def change
    create_table :review_responses do |t|
      t.string :response
      t.integer :review_id
      t.references :review

      t.timestamps
    end
    add_index :review_responses, :review_id
  end
end
