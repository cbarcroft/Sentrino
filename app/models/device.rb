class Device < ActiveRecord::Base
  attr_accessible :id, :nickname, :model, :ip
  
  has_many :tasks
 
  validates :model,  :presence => true
  validates :ip, :presence => true,
                    :length => { :minimum => 8 }
end