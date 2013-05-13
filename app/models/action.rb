class Action < ActiveRecord::Base
	belongs_to :device
	belongs_to :action_type

 	attr_accessible :action_type_id, :device_id

 	def combined_name
 		self.device.nickname + " | " + self.action_type.name
 	end
end
