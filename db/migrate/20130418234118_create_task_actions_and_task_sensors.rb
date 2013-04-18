class CreateTaskActionsAndTaskSensors < ActiveRecord::Migration
  def change
	create_table :task_actions do |t|
    	t.integer :task_id
    	t.integer :action_id
    	t.string :parameters
    	t.string :post_action
 
    	t.timestamps
    end

	create_table :task_sensors do |t|
    	t.integer :task_id
    	t.integer :sensor_id
    	t.string :post_action
 
    	t.timestamps
    end
  end
end
