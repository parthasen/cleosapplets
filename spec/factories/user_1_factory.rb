FactoryGirl.define do
	sequence :username do |n|
		"username#{n}"
	end
	sequence :email do |n|
		"username#{n}@email.com"
	end
	sequence :fb_user_id do |n|
		"#{n}"
	end
  factory :user_1, class: User do
		username
		email
		fb_user_id
		password "password123"
		password_confirmation "password123"
  end
end