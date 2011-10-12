class CreateLinkClicks < ActiveRecord::Migration
  def change
    create_table :link_clicks do |t|
      t.string :url

      t.timestamps
    end
  end
end
