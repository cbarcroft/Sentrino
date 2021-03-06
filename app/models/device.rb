class Device < ActiveRecord::Base
  attr_accessible :nickname, :model, :ip, :user_id, :image, :port

  has_many :actions
  has_many :action_types, :through => :actions

  has_many :sensors 
  has_many :sensor_types, :through => :sensors

  has_many :tasks
  belongs_to :user
 
  validates :model,  :presence => true

  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  validates :ip, :presence => true,
                 :length => { :minimum => 8 },
                 :format => { :with => @ip_regex, :message => "Invalid IP address. Must be in format: X.X.X.X "}

  UNSUPPORTED_METHOD_MESSAGE = "Unsupported on this device."
  PARSE_ERROR_MESSAGE = "Problem decoding response."

  # Methods related to actual device communications below

  #Sensors
  def status
    response = communicateWithDevice("ping");
    if response
      response["err"] ? UNSUPPORTED_METHOD_MESSAGE : "Online"
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  def temp
    response = communicateWithDevice("temp");
    if response
      response["err"] ? UNSUPPORTED_METHOD_MESSAGE : (response["temp"].to_f / 100).to_s + "&deg;F"
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  def humidity
    response = communicateWithDevice("hmdy");
    if response
      response["err"] ? UNSUPPORTED_METHOD_MESSAGE : (response["hmdy"].to_f / 100).to_s + "%"
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  #Actions
  def beep
    response = communicateWithDevice("beep");
    if response
      response["err"] ? UNSUPPORTED_METHOD_MESSAGE : true;
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  def light(duration = 5)
    response = communicateWithDevice("lght", duration);
    if response
      response["err"] ? UNSUPPORTED_METHOD_MESSAGE : true;
    else
      return PARSE_ERROR_MESSAGE
    end
  end

  private
    def communicateWithDevice(method, args = nil)
      begin
        url = "http://#{self.ip}:#{self.port || '80'}/$$#{method}"
        if args then url += "/%%#{args}" end

        p "Fetching #{url}"
        response = JSON.parse(HTTParty.get(url, {:timeout => 5000}));
        return false unless response
        return response["error"] if response["error"]["err"] == true
	      return response["body"]
      rescue
        return false
      end
    end

end