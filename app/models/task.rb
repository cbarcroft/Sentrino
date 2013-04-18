class Task < ActiveRecord::Base
  belongs_to :user
  has_many :task_action
  has_many :task_sensor

  attr_accessible :frequency, :name

  validates :name,  :presence => true
  validates :frequency,  :presence => true
end
