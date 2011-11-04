class AddDisplayNameToPlatforms < ActiveRecord::Migration
  def change
    add_column :platforms, :display_name, :string
  end
end
