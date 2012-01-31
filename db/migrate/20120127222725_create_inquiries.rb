class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.text :details
      t.integer :business_id
      t.boolean :is_reviewed, :default => false
      t.boolean :is_archived, :default => false

      t.timestamps
    end
  end
end
