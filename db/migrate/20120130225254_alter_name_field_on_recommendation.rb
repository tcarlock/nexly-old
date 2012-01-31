class AlterNameFieldOnRecommendation < ActiveRecord::Migration
  def change
  	rename_column :recommendations, :name, :first_name
  	add_column :recommendations, :last_name, :string
  end
end
