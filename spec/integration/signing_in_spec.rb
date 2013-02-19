require 'spec_helper'

feature 'Signing in' do
	before do
		Factory(:user, :email => "x@y.z")

		visit '/'
		click_link 'Sign in'
		fill_in 'email', :with => 'x@y.z'
		fill_in 'password', :with => 'password'
		click_button "Sign in"
	end

	scenario 'Signing in' do
		page.should have_content("Signed in successfully.")
	end

	scenario 'Signing out' do
		click_link 'Sign out'
		page.should have_content("Signed out successfully.")
	end
end