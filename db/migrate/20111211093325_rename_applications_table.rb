class RenameApplicationsTable < ActiveRecord::Migration
  def change
  	rename_table :applications, :features
  end
end
