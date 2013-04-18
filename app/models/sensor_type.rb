class SensorType < ActiveRecord::Base
  attr_accessible :name, :method

  has_many :sensors
  has_many :devices, :through => :sensors
end