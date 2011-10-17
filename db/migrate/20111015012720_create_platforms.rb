class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :name

      t.timestamps
    end
    add_index :platforms, :name
  end
end
