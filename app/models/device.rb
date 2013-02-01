class Device < ActiveRecord::Base
  attr_accessible :nickname, :model, :ip, :user_id
  
  has_many :actions
  has_many :actiontypes, :through => :actions
  belongs_to :user
 
  validates :model,  :presence => true
  validates :ip, :presence => true,
                    :length => { :minimum => 8 }

  def ping
  	Curl.get("http://#{self.ip}/ping").body_str
  end

  def temp
  	Curl.get("http://#{self.ip}/temp").body_str
  end

  def humidity
  	Curl.get("http://#{self.ip}/humidity").body_str
  end
end