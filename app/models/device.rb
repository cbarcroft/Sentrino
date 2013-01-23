class Device < ActiveRecord::Base
  attr_accessible :id, :nickname, :model, :ip
  
  has_many :actions
 
  validates :model,  :presence => true
  validates :ip, :presence => true,
                    :length => { :minimum => 8 }
end