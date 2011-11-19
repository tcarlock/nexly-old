class RemoveVersionIdFromBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :version_id
  end
end
