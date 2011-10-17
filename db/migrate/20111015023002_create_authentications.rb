class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :platform_id
      t.string :uid
      t.string :token
      t.string :secret
      t.integer :business_id

      t.timestamps
    end
  end
end
