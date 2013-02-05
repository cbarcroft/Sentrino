class Action < ActiveRecord::Base
	belongs_to :device
	has_one :actiontype

 	attr_accessible :action_id, :device_id

 	def name
 		ActionType.find(self.action_id).name
 	end

 	def route
 		ActionType.find(self.action_id).route
 	end
end
