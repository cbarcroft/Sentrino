class Task < ActiveRecord::Base
  belongs_to :action
  has_one :action_type, :through => :action
  belongs_to :device

  attr_accessible :frequency, :name, :action_id, :result_action

  validates :name,  :presence => true
  validates :frequency,  :presence => true
  validates :action_id,  :presence => true
  validates :result_action,  :presence => true, :inclusion => { :in => %w(email store), :message => "%{value} is not a valid choice." }
end
