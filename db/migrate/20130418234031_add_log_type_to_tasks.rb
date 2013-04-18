class AddLogTypeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :log_type, :string
  end
end
