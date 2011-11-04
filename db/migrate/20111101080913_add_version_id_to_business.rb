class AddVersionIdToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :version_id, :integer
  end
end
