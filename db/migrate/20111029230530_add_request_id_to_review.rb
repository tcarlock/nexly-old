class AddRequestIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :review_request_id, :integer
  end
end
