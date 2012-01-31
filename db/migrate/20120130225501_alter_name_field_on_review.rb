class AlterNameFieldOnReview < ActiveRecord::Migration
  def change
  	rename_column :reviews, :name, :first_name
  	add_column :reviews, :last_name, :string
  end
end
