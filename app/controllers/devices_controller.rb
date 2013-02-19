class DevicesController < ApplicationController
  before_filter :find_device, :only => [:show, :edit, :update, :destroy]
  
  # GET /devices
  def index
    @devices = Device.where(:user_id => current_user[:id])
  end

  # GET /devices/1
  def show
    @action_replies = {}
    @device.action_types.each do |action_type|
      reply = @device.send(action_type.route)
      @action_replies[action_type.name] = reply ? reply : "N/A" 
    end

    @tasks = @device.tasks  
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
      if register_actions(@device)
        redirect_to @device, notice: 'Device was successfully created, and its actions have been automatically registered.' 
      else
        redirect_to @device, notice: 'Device was successfully created.  We were not able to automatically register actions for the device.'
      end
    else
      render action: "new" 
    end
  end

  # PUT /devices/1
  def update
    if @device.update_attributes(params[:device])
      @device.actions.destroy_all
      if register_actions(@device)
        redirect_to @device, notice: 'Device was successfully updated. Actions were automatically re-registered.'
      else
        redirect_to @device, notice: 'Device was successfully updated. Actions were not automatically re-registered.'
      end
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
      @device = Device.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The device you were looking for could not be found."
        redirect_to devices_path
    end

    def register_actions(device)
      ActionType.all.each do |actiontype|
        reply = device.send(actiontype[:route])
        if reply != "Problem decoding response."
          @action = device.actions.build
          @action[:action_type_id] = actiontype[:id]
          @action.save
        end
      end
      return true
    end

end

