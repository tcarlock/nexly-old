class CreateNewsPosts < ActiveRecord::Migration
  def change
    create_table :news_posts do |t|
      t.string :title
      t.text :content
      t.integer :business_id

      t.timestamps
    end
  end
end
