class AddPlatformFields < ActiveRecord::Migration
  def change
    add_column :platforms, :icon, :string
    add_column :platforms, :display_order, :integer
    add_column :platforms, :details, :string
    add_column :platforms, :is_available, :boolean, :default => true
  end
end
