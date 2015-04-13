require "rails_helper"

RSpec.describe User, '.username', :type => :model do
	it "does not save when nil" do
		user = FactoryGirl.build(:user_1, :username => nil)
		expect(user.save).to equal(false)
	end
	it "does not save with invalid characters" do
		#user = FactoryGirl.build(:user_1, :username => "!@#$%)")
		#expect(user.save).to equal(false)
	end
end
RSpec.describe User, '.email', :type => :model do
	it "does not save when nil" do
		user = FactoryGirl.build(:user_1, :email => nil)
		expect(user.save).to equal(false)
	end
	it "does not save with invalid characters" do
		#user = FactoryGirl.build(:user_1, :email => "!@#$%)")
		#expect(user.save).to equal(false)
	end
end
RSpec.describe User, '.password_digest', :type => :model do
	it "does not save when nil" do
		user = FactoryGirl.build(:user_1, :password => nil, :password_confirmation => nil)
		expect(user.save).to equal(false)
	end
	it "does not save when not a match" do
		user = FactoryGirl.build(:user_1, :password => "firstAttempt", :password_confirmation => "secondAttempt")
		expect(user.save).to equal(false)
	end
	it "saves with a matching password and password_confirmation" do
		user = FactoryGirl.build(:user_1, :password => "good_password", :password_confirmation => "good_password")
		expect(user.save).to equal(true)
	end
end
RSpec.describe User, :type => :model do
	describe "dependencies" do
		before(:example) do
			@user = FactoryGirl.create(:user_1)
		end
		it "deletes ... when deleted" do

		end
	end
end
RSpec.describe User, :type => :model do
	describe "callbacks" do
		before(:example) do
    	@user = FactoryGirl.create(:user_1)
  	end
  	
		it "creates an authentication token" do
			expect(@user.tokens.any?).to equal(true)
		end
		it "does not create an empty auth token" do
			expect(@user.tokens[0].auth_token.nil?).to equal(false)
		end
		
	end
end