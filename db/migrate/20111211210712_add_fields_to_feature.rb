class AddFieldsToFeature < ActiveRecord::Migration
  def change
    add_column :features, :display_order, :integer
    add_column :features, :lookup_key, :string
  end
end
