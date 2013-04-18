class TaskAction < ActiveRecord::Base
  belongs_to :task
  belongs_to :action

  attr_accessible :post_action, :parameters

  validates :post_action,  :presence => true
  validates :parameters,  :presence => true
end
