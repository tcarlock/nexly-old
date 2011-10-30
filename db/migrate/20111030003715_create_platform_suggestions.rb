class CreatePlatformSuggestions < ActiveRecord::Migration
  def change
    create_table :platform_suggestions do |t|
      t.string :url

      t.timestamps
    end
  end
end
