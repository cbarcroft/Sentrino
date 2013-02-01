class Action < ActiveRecord::Base
	has_one :device
	has_one :actiontype

 	attr_accessible :action_id, :device_id
end
