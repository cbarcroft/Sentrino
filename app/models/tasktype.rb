class TaskType < ActiveRecord::Base
  attr_accessible :name, :route
  belongs_to :task
  
end