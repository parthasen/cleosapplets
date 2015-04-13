require "rails_helper"

#The standard rest routes for the user controller
RSpec.describe "Users controller rest routing", :type => :routing do

	it "routes to index" do
		expect(:get => "/api/1/users").to route_to(
			:controller => "api/v1/users",
			:action => "index"
		)
	end
	it "routes to show" do
		expect(:get => "/api/1/users/1").to route_to(
			:controller => "api/v1/users",
			:action => "show",
			:id => "1"
		)
	end
	it "routes to update" do
		expect(:put => "/api/1/users/1/").to route_to(
			:controller => "api/v1/users",
			:action => "update",
			:id => "1"
		)
	end
	it "routes to update" do
		expect(:patch => "/api/1/users/1/").to route_to(
			:controller => "api/v1/users",
			:action => "update",
			:id => "1"
		)
	end
	it "routes to delete" do
		expect(:delete => "/api/1/users/1/").to route_to(
			:controller => "api/v1/users",
			:action => "destroy",
			:id => "1"
		)
	end
	it "routes create to register" do
		expect(:post => "/api/1/users/register").to route_to(
			:controller => "api/v1/users",
			:action => "register"
		)
	end
	it "routes create to login" do
		expect(:post => "/api/1/users/login").to route_to(
			:controller => "api/v1/users",
			:action => "login"
		)
	end
	it "routes create to facebook_login" do
		expect(:post => "/api/1/users/facebook_login").to route_to(
			:controller => "api/v1/users",
			:action => "facebook_login"
		)
	end
	it "routes create to logout" do
		expect(:post => "/api/1/users/logout").to route_to(
			:controller => "api/v1/users",
			:action => "logout"
		)
	end
end