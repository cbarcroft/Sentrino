class ActionType < ActiveRecord::Base
  attr_accessible :name, :method

  has_many :actions
  has_many :devices, :through => :actions
end