class Action < ActiveRecord::Base
	belongs_to :device
	belongs_to :action_type

 	attr_accessible :action_id, :device_id
end
