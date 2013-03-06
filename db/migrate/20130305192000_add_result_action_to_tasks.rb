class AddResultActionToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :result_action, :string
  end
end
