class AddPhoneNumberToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :phone, :string
  end
end
