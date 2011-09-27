class CreateBusinessUsers < ActiveRecord::Migration
  def up
    create_table :business_users do |t|
      t.integer :user_id
      t.integer :business_id
      
      t.timestamps
    end
  end

  def down
    drop_table :business_users
  end
end
