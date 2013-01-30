class Device < ActiveRecord::Base
  attr_accessible :nickname, :model, :ip, :user_id
  
  has_many :device_actions
  belongs_to :user
 
  validates :model,  :presence => true
  validates :ip, :presence => true,
                    :length => { :minimum => 8 }
end