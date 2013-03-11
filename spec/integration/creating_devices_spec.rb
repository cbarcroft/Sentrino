require 'spec_helper'

feature "Creating devices" do

	before do
		@user = Factory(:user)
		@device = Factory(:device)

		visit '/'
		click_link "Sign in"
		fill_in 'email', :with => @user.email
		fill_in 'password', :with => @user.password
		click_button "Sign in"
		click_link "Add a Device"
	end

	scenario "creating a device with no attached image" do
		fill_in 'device_nickname', :with => @device.nickname
		fill_in 'device_model', :with => @device.model
		fill_in 'device_ip', :with => @device.ip
		fill_in 'device_port', :with => @device.port
		click_button 'Create Device'
		page.should have_content 'Device was successfully created'
	end

	scenario "creating a device an attached image" do
		fill_in 'device_nickname', :with => @device.nickname
		fill_in 'device_model', :with => @device.model
		fill_in 'device_ip', :with => @device.ip
		attach_file('device_image', 'spec/support/images/waterfall.jpg')
		click_button 'Create Device'
		page.should have_content 'Device was successfully created'
	end

	scenario "using an invalid ip" do
		fill_in 'device_nickname', :with => @device.nickname
		fill_in 'device_model', :with => @device.model
		bad_ips = ['123', '12.12.1234', '1.2.3.4.5', '1.2',
			'11111111111', 'IP Address', 'George',
			'one-ninety-two.twenty-five.five.twelve']
		bad_ips.each do |bad_ip|
			fill_in 'device_ip', :with => bad_ip
			click_button 'Create Device'
			page.should have_content 'prohibited this device from being saved'
		end
	end

end