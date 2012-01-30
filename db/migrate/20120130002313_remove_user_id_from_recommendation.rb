class RemoveUserIdFromRecommendation < ActiveRecord::Migration
  def change
  	delete_column :recommendations, :user_id
  end
end
