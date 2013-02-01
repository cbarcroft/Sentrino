class CreateActionTypes < ActiveRecord::Migration
  def change
    create_table :action_types do |t|
      t.string :name
      t.string :route

      t.timestamps
    end
  end
end
