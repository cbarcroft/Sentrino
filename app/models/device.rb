class Device < ActiveRecord::Base
  attr_accessible :nickname, :model, :ip, :user_id, :image, :port

  has_many :actions
  has_many :action_types, :through => :actions

  has_many :sensors
  has_many :sensor_types, :through => :sensors

  has_many :tasks
  belongs_to :user
 
  validates :model,  :presence => true

  has_attached_file :image,
   :storage => :s3,
   :s3_credentials => "config/s3.yml",
   :path => "/:style/:id/:filename"

  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/
  validates :ip, :presence => true,
                 :length => { :minimum => 8 },
                 :format => { :with => @ip_regex, :message => "Invalid IP address. Must be in format: X.X.X.X "}

  UNSUPPORTED_METHOD_MESSAGE = "Unsupported on this device."
  PARSE_ERROR_MESSAGE = "Problem decoding response."

  # Methods related to actual device communications below

  def status
    response =communicateWithDevice("ping");
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

  private
    def communicateWithDevice(method)
      #return false # Enable this to avoid device timeouts if it is acting up
      begin
        p "Fetching http://#{self.ip}:#{self.port || '80'}/$$#{method}"
        response = JSON.parse(HTTParty.get("http://#{self.ip}:#{self.port || '80'}/$$#{method}", {:timeout => 5000}));
        return false unless response
        return response["error"] if response["error"]["err"] == true
	return response["body"]
      rescue
        return false
      end
    end

end