class ActionType < ActiveRecord::Base
  attr_accessible :name, :route
  belongs_to :device_action
end