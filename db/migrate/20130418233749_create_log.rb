class CreateLog < ActiveRecord::Migration
  def change
	create_table :log do |t|
    	t.integer :user_id
    	t.text :log_text
    	t.string :log_type
 
    	t.timestamps
    end
  end
end
