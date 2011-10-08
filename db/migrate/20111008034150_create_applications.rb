class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :title
      t.text :details
      t.float :price
      t.boolean :is_public, :default => true

      t.timestamps
    end
  end
end
