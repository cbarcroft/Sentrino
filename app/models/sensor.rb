class Sensor < ActiveRecord::Base
	belongs_to :device
	belongs_to :sensor_type

 	attr_accessible :sensor_type_id, :device_id
end
