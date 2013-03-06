class TasksController < ApplicationController
	before_filter :is_logged_in?
	before_filter :find_device
	before_filter :find_task, :only => [:show, :edit, :update, :destroy]
	before_filter :find_actions_with_types, :only => [:new, :edit]

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
			@device = current_user.devices.find(params[:device_id])
			rescue ActiveRecord::RecordNotFound
			  flash[:alert] = "The device you were looking for could not be found."
			  redirect_to devices_path
		end

		def find_task
			@task = @device.tasks.find(params[:id])
		end

		def find_actions_with_types
			@actions_with_types = @device.actions.joins(:action_type)
		end
		
		def is_logged_in?
		    unless !current_user.nil?
		    flash[:notice] = "You must be logged in to view that."
		    redirect_to root_path
		  end
		end
end