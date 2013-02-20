FactoryGirl.define do
	factory :user do
		email "x@y.z"
		password "password"
		password_confirmation "password"

		factory :confirmed_user do
			after_create do |user|
				user.confirm!
			end
		end
	end
end