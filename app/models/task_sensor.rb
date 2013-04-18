class TaskSensor < ActiveRecord::Base
  belongs_to :task
  belongs_to :sensor

  attr_accessible :post_action

  validates :post_action,  :presence => true
end
