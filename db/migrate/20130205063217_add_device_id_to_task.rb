class AddDeviceIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :device_id, :integer
  end
end
