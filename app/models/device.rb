class Device < ActiveRecord::Base
  attr_accessible :nickname, :model, :ip, :user_id
  
  has_many :actions
  has_many :actiontypes, :through => :actions
  has_many :tasks
  belongs_to :user
 
  validates :model,  :presence => true
  validates :ip, :presence => true,
                    :length => { :minimum => 8 }

  UNSUPPORTED_METHOD_MESSAGE = "Unsupported on this device."
  PARSE_ERROR_MESSAGE = "Problem decoding response."

  def ping
  	comms =communicateWithDevice("ping");
    if comms
      comms["err"] ? UNSUPPORTED_METHOD_MESSAGE : "Online"
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  def temp
  	comms = communicateWithDevice("temp");
    if comms
      comms["err"] ? UNSUPPORTED_METHOD_MESSAGE : (comms["temp"].to_f / 100).to_s + "&deg;F"
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  def humidity
  	comms = communicateWithDevice("hmdy");
    if comms
      comms["err"] ? UNSUPPORTED_METHOD_MESSAGE : comms["humidity"]
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  private
    def communicateWithDevice(method)
      begin
        response = JSON.parse(HTTParty.get("http://#{self.ip}/$$#{method}"));
        return false unless response
        return response["error"] if response["error"]["err"] == true
		    return response["body"]
      rescue
        return false
      end
    end

end