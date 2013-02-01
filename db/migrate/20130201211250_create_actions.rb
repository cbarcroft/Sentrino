class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.integer :device_id
      t.integer :action_id

      t.timestamps
    end
  end
end
