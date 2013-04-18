class AddReadingsTables < ActiveRecord::Migration
  def change
	create_table :sensors do |t|
    	t.integer :device_id
    	t.integer :sensor_type_id
 
    	t.timestamps
    end

	create_table :sensor_types do |t|
    	t.string :name
    	t.string :method
 
    	t.timestamps
    end
  end
end
