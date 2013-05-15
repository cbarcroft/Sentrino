class Sensor < ActiveRecord::Base
	belongs_to :device 
	belongs_to :sensor_type

 	attr_accessible :sensor_type_id, :device_id

 	def combined_name
 		self.device.nickname + " | " + self.sensor_type.name
 	end
end
