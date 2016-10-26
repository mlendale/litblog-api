FactoryGirl.define do
	factory :user do
		name { FFaker::Name }
		email { FFaker::Internet.email }
		password "pass123"
		password_confirmation "pass123"
	end
	
	factory :post do
		user
		content {FFaker::Lorem.sentence}
	end
end
