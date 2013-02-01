class ActionType < ActiveRecord::Base
  attr_accessible :name, :route

  has_many :actions
  has_many :devices, :through => :actions
end