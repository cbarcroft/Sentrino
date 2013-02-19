class FixColumnName < ActiveRecord::Migration
  def up
	rename_column :actions, :action_id, :action_type_id
  end

  def down
  	rename_column :actions, :action_type_id, :action_id
  end
end
