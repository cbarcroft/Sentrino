require 'spec_helper'

feature 'Signing up' do
	before do
		visit '/'
		click_link 'Sign up'
	end

	scenario 'Successful sign up' do
		fill_in "email", :with => "x@y.z"
		fill_in "password", :with => "password"
		fill_in "password_confirmation", :with => "password"
		click_button "Sign up"
		page.should have_content "Welcome! You have signed up successfully."
	end

	scenario 'Password under 8 characters' do
		fill_in "email", :with => "x@y.z"
		fill_in "password", :with => "1234567"
		fill_in "password_confirmation", :with => "1234567"
		click_button "Sign up"
		page.should have_content "Password is too short (minimum is 8 characters)"
	end

end