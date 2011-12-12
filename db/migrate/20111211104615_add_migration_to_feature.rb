class AddMigrationToFeature < ActiveRecord::Migration
  def change
    add_column :features, :icon, :string
  end
end
