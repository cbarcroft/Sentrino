require 'spec_helper'

feature 'Signing in' do
	before do
		user = Factory(:user)
		visit '/'
		click_link 'Sign in'
		fill_in 'email', :with => user.email
		fill_in 'password', :with => user.password
		click_button "Sign in"
	end

	scenario 'Signing in' do
		page.should have_content(I18n.t("devise.sessions.signed_in"))
	end

	scenario 'Signing out' do
		click_link 'Logout'
		page.should have_content(I18n.t("devise.sessions.signed_out"))
	end
end