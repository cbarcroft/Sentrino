class DeviceAction < ActiveRecord::Base
  attr_accessible :nickname
  belongs_to :device
  has_one :actiontype 
end
