class TasksController < ApplicationController
	before_filter :find_device

	def new
		@task = @device.tasks.build
	end

	private
		def find_device
			@device = Device.find(params[:device_id])
		end
end