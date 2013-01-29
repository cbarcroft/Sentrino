class CreateDeviceActions < ActiveRecord::Migration
  def change
    create_table :device_actions do |t|
      t.string :nickname
      t.integer :actiontype_id
      t.integer :device_id

      t.timestamps
    end
  end
end
