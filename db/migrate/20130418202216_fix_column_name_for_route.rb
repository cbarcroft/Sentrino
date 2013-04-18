class FixColumnNameForRoute < ActiveRecord::Migration
	def change
		rename_column :action_types, :route, :method
	end
end
