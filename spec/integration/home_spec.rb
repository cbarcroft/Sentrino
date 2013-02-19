require 'spec_helper'

feature "Home Page" do
	scenario "exists" do
		visit '/'
		page.should have_content "Sentrino"
	end
end