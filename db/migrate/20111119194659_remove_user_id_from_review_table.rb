class RemoveUserIdFromReviewTable < ActiveRecord::Migration
  def up
    remove_column :reviews, :user_id
  end
end
