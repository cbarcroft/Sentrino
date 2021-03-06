class Task < ActiveRecord::Base
  belongs_to :user
  has_many :task_actions
  has_many :task_sensors
  accepts_nested_attributes_for :task_actions, allow_destroy: true
  accepts_nested_attributes_for :task_sensors, allow_destroy: true

  attr_accessible :frequency, :name, :log_type, :task_actions_attributes, :task_sensors_attributes

  validates :name,  :presence => true
  validates :frequency,  :presence => true

  def all_involved_devices
  	devices = []
  	self.task_sensors.each do |sensor|
  		devices << sensor.device_id
  	end
  	self.task_actions.each do |action|
  		devices << action.device_id
  	end
  	devices
  end
end
