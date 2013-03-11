FactoryGirl.define do
	factory :task do
		name 'Pinging'
		action 'Ping'
		result_action 'Store'
	end
end