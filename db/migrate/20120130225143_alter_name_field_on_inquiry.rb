class AlterNameFieldOnInquiry < ActiveRecord::Migration
  def change
  	rename_column :inquiries, :name, :first_name
  	add_column :inquiries, :last_name, :string
  end
end
