module ApplicationHelper

	def all_tasks(user)
		user.devices.flat_map { |device| device.tasks.flat_map { |task| task } }
	end

end
