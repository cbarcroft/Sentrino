class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :frequency
      t.references :action

      t.timestamps
    end
    add_index :tasks, :action_id
  end
end
