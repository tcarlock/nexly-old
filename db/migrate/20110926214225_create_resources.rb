class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.string :link
      t.integer :resource_type_id
      t.integer :business_id

      t.timestamps
    end
  end
end
