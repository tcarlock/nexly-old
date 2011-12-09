class AddIpAddressToPageView < ActiveRecord::Migration
  def change
    add_column :page_views, :ip_address, :string
  end
end
