class TasksController < ApplicationController
	before_filter :find_device
	before_filter :find_task, :only => [:show, :edit, :update, :destroy]
	before_filter :find_actions_with_types, :only => [:new, :create, :edit, :update]

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

	def cron
		@tasks = Task.all
		@active_crons = get_active_crons()

		@tasks.each do |task|
			if @active_crons[task.frequency]
				result = task.device.send(task.action_type)
				if task.result_action == "email"
					#task.device.user.email
				elsif task.result_action == "store"
					#store as a result object (need to create)
				end
			end
		end
	end

	private
		def find_device
			@device = Device.find(params[:device_id])
		end

		def find_task
			@task = @device.tasks.find(params[:id])
		end

		def find_actions_with_types
			@actions_with_types = @device.actions.joins(:action_type)
		end

		def get_active_crons
			@current_hour = Time.now.strftime("%H").to_i
			@current_minute = Time.now.strftime("%M").to_i

			return {
				"1M" => true,
				"5M" => @current_minute%5 == 0 ? true : false,
				"30M" => @current_minute%30 == 0 ? true : false.
				"1H" => @current_minute == 0 ? true : false,
				"12H" => @current_hour%12 == 0 && @current_minute == 0 ? true : false,
				"24H" => @current_hour == 0 && @current_minute == 0 ? true : false
			}
		end
end