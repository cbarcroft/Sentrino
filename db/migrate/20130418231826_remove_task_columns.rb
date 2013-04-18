class RemoveTaskColumns < ActiveRecord::Migration
  def change
  	remove_column :tasks, :action_id
  	remove_column :tasks, :device_id
  	remove_column :tasks, :result_action
  end
end
