class TaskSensor < ActiveRecord::Base
  belongs_to :task
  belongs_to :sensor

  attr_accessible :post_action, :sensor_id

  validates :post_action,  :presence => true

  def device_id
  	self.sensor.device_id
  end
end
