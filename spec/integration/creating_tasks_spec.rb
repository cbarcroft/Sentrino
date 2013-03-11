require 'spec_helper'

feature "Creating Tasks" do

	before do
		Factory(:user)
		Factory(:device)
		visit '/'
		click_link 'Sign in'
		fill_in 'email', :with => 'x@y.z'
		fill_in 'password', :with => 'password'
		click_button "Sign in"

		click_link 'Add a Device'
		fill_in 'device_nickname', :with => 'George'
		fill_in 'device_model', :with => 'Uno'
		fill_in 'device_ip', :with => '192.54.43.2'
		fill_in 'device_port', :with => '8000'
		click_button 'Create Device'

		page.should have_content 'Device was successfully created'
	end

	scenario "Creating a task" do
		click_link 'New Task'
		page.should have_content "New Task for"

		fill_in 'task_name', :with => 'Pinging'
		select 'Ping', :from => 'task_action_id'
		select 'Store', :from => 'task_result_action'
		click_button 'Create Task'
		page.should have_content 'Task has been scheduled.'
	end

	scenario "Not filling in a name" do
		click_link 'New Task'
		click_button 'Create Task'
		page.should have_content 'Task has not'
	end

end