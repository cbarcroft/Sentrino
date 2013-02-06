class TasksController < ApplicationController
	before_filter :find_device
	before_filter :find_task, :only => [:show, :edit, :update, :destroy]

	def new
		@task = @device.tasks.build
	end
	
	def create
		@task = @device.tasks.build(params[:task])
		if @task.save
			flash[:notice] = "Task has been scheduled."
			redirect_to @device
		else
			flash[:alert] = "Task has not been scheduled."
			render :action => "new"
		end
	end

	def show
	end

	def edit
	end
	
	def update
		if @task.update_attributes(params[:task])
			flash[:notice] = "Task has been updated."
			redirect_to @device
		else
			flash[:alert] = "Task has not been updated."
			render :action => "edit"
		end
	end

	def destroy
		@task.destroy
		flash[:notice] = "Task has been deleted."
		redirect_to @device
	end

	private
		def find_device
			@device = Device.find(params[:device_id])
		end
		def find_task
			@task = @device.tasks.find(params[:id])
		end
end