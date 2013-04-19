class Task < ActiveRecord::Base
  belongs_to :user
  has_many :task_actions
  has_many :task_sensors
  accepts_nested_attributes_for :task_actions, allow_destroy: true
  accepts_nested_attributes_for :task_sensors, allow_destroy: true

  attr_accessible :frequency, :name, :log_type

  validates :name,  :presence => true
  validates :frequency,  :presence => true
end
