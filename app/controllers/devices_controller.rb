class DevicesController < ApplicationController
  before_filter :is_logged_in?
  before_filter :find_device, :only => [:show, :edit, :update, :destroy]
  
  # GET /devices
  def index
    @devices = Device.where(:user_id => current_user[:id])
  end

  # GET /devices/1
  def show
    @sensor_replies = {}
    @device.sensor_types.each do |sensor_type|
      reply = @device.send(sensor_type.method)
      @sensor_replies[sensor_type.name] = reply ? reply : "N/A" 
    end

    @tasks = current_user.tasks  
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  def create
    @device = Device.new(params[:device].merge :user_id => current_user[:id])
    if @device.save
      if register_sensors(@device)
        redirect_to @device, notice: 'Device was successfully created, and its sensors have been automatically registered.' 
      else
        redirect_to @device, notice: 'Device was successfully created.  We were not able to automatically register sensors for the device.'
      end
    else
      render action: "new" 
    end
  end

  # PUT /devices/1
  def update
    if @device.update_attributes(params[:device])
      redirect_to @device, notice: 'Device was successfully updated.'
    else
      render action: "edit" 
    end
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
    redirect_to devices_url 
  end
  
  private
    def find_device
      @device = current_user.devices.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The device you were looking for could not be found."
        redirect_to devices_path
    end
    
    def is_logged_in?
      unless !current_user.nil?
        flash[:notice] = "You must be logged in to view that."
        redirect_to root_path
      end
    end

    def register_sensors(device)
      SensorType.all.each do |sensortype|
        reply = device.send(sensortype[:method])
        if reply != "Problem decoding response."
          @sensor = device.sensors.build
          @sensor[:action_type_id] = sensortype[:id]
          @sensor.save
        end
      end
      return true
    end

end

