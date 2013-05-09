class TaskSensor < ActiveRecord::Base
  belongs_to :task
  belongs_to :sensor

  attr_accessible :post_action, :sensor_id

  validates :post_action,  :presence => true
end
