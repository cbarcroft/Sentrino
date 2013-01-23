class Task < ActiveRecord::Base
  attr_accessible :nickname
  belongs_to :device
  has_one :tasktype
  
  
end