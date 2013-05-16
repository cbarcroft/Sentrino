class TasksController < ApplicationController
	before_filter :is_logged_in?
	before_filter :find_task, :only => [:show, :edit, :update, :destroy]

	def home
		@tasks = current_user.tasks
		@devices = current_user.devices
	end

	#ajax
	def index
		@tasks = current_user.tasks

		render :partial => "task_list"
	end

	#ajax
	def new
		@task = current_user.tasks.build
		@devices = current_user.devices

		render :partial => "form" 
	end
	
	#ajax
	def create
		@task = current_user.tasks.build(params[:task])

		if @task.save
			@status = {
				:status => true,
				:message => "Task has been scheduled.",
				:task => @task
			}
		else
			@status = {
				:status => false,
				:message => "Task has not been scheduled.",
				:task => nil
			}
		end
		render :json => @status
	end

	def edit
		render :partial => "form" 
	end
	
	def update
		if @task.update_attributes(params[:task])
			@status = {
				:status => true,
				:message => "Task has been updated.",
				:task => @task
			}
		else
			@status = {
				:status => false,
				:message => "Task has not been updated.",
				:task => nil
			}
		end
		render :json => @status
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

		def find_task
			@task = Task.find(params[:id])
		end
		
		def is_logged_in?
		    unless !current_user.nil?
		      flash[:notice] = "You must be logged in to view that."
		      redirect_to root_path
		    end
		end
	    

		def get_active_crons
			@current_hour = Time.now.strftime("%H").to_i
			@current_minute = Time.now.strftime("%M").to_i

			return {
				"1M" => true,
				"5M" => @current_minute%5 == 0 ? true : false,
				"30M" => @current_minute%30 == 0 ? true : false,
				"1H" => @current_minute == 0 ? true : false,
				"12H" => @current_hour%12 == 0 && @current_minute == 0 ? true : false,
				"24H" => @current_hour == 0 && @current_minute == 0 ? true : false
			}
		end
end