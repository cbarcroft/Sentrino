class Task < ActiveRecord::Base
  belongs_to :action
  has_one :action_type, :through => :action
  belongs_to :device

  attr_accessible :frequency, :name, :action_id

  validates :name,  :presence => true
  validates :frequency,  :presence => true
  validates :action_id,  :presence => true
end
