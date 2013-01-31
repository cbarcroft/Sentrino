class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :id
      t.string :nickname
      t.string :model
      t.string :ip
      t.integer :user_id

      t.timestamps
    end
  end
end
