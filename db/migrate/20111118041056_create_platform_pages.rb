class CreatePlatformPages < ActiveRecord::Migration
  def change
    create_table :platform_pages do |t|
      t.integer :platform_id
      t.integer :business_id
      t.string :external_id

      t.timestamps
    end
  end
end
