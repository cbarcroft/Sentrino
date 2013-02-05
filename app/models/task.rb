class Task < ActiveRecord::Base
  has_one :action
  belongs_to :device

  attr_accessible :frequency, :name
end
