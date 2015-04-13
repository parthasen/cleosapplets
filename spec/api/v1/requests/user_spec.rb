require "rails_helper"

#-#-#-#-#REST#-#-#-#-#
RSpec.describe User, :type => :request do
  describe "Index" do
    before(:example) do
      @user = FactoryGirl.create(:user_1)
      token = @user.tokens[0].auth_token
      @header = {::Settings.token_header => token, "Email" => @user.email, ::Settings.main_api_header => ::Settings.main_api_key}
    end
    # get /api/1/users
    it "checks index json response" do
      FactoryGirl.create_list(:user_1, 10)
      get '/api/1/users', nil, @header
      expect(response.status).to eq(200) #ok
      expect(json["users"]).to_not eq(nil)
    end
  end
end
RSpec.describe User, :type => :request do
  describe "Show" do
    before(:example) do
      @user = FactoryGirl.create(:user_1)
      token = @user.tokens[0].auth_token
      @header = {::Settings.token_header => token, "Email" => @user.email, ::Settings.main_api_header => ::Settings.main_api_key}
    end
    # get /api/1/users/1
    it "checks show json response" do
      get "/api/1/users/#{@user.id}", nil, @header
      expect(response.status).to eq(200) #ok
      expect(json["user"]["id"]).to eq(1)
    end
  end
end
RSpec.describe User, :type => :request do
  describe "Update" do
    before(:example) do
      @user = FactoryGirl.create(:user_1)
      token = @user.tokens[0].auth_token
      @header = {::Settings.token_header => token, "Email" => @user.email, ::Settings.main_api_header => ::Settings.main_api_key}
      @attrs = FactoryGirl.attributes_for(:user_1)
      @attrs["email"] = @user.email
      @attrs["username"] = @user.username
    end
    # put /api/1/users/1
    it "checks update json response" do
      @attrs["email"] = "cole@email.com"
      hash = {"user" => @attrs}
      #This uses users 1 header
      put "/api/1/users/#{@user.id}", hash, @header
      expect(response.status).to eq(200) #ok
      expect(json["user"]["email"]).to eq("cole@email.com")
    end
    it "makes sure a user cannot alter another users information" do
      FactoryGirl.create(:user_1)
      @attrs["email"] = "cole@email.com"
      hash = {"user" => @attrs}
      #This uses users 1 header and user 2 id
      put "/api/1/users/#{@user.id + 1}", hash, @header
      expect(response.status).to eq(403) #forbidden
    end
    it "makes sure a user can't update to bad values" do
      @attrs["email"] = ""
      hash = {"user" => @attrs}
      #This uses users 1 header
      put "/api/1/users/#{@user.id}", hash, @header
      expect(response.status).to eq(422) #ok
    end
  end
end
RSpec.describe User, :type => :request do
  describe "Destroy" do
    before(:example) do
      @user = FactoryGirl.create(:user_1)
      token = @user.tokens[0].auth_token
      @header = {::Settings.token_header => token, "Email" => @user.email, ::Settings.main_api_header => ::Settings.main_api_key}
      @attrs = FactoryGirl.attributes_for(:user_1)
      @attrs["email"] = @user.email
      @attrs["username"] = @user.username
    end
    # delete /api/1/users/1
    it "makes sure a user can delete their accout" do
      hash = {"user" => @attrs}
      #This uses users 1 header
      delete "/api/1/users/#{@user.id}", hash, @header
      expect(response.status).to eq(200) #ok
      expect(User.count).to eq(0)
    end
    # delete /api/1/users/2
    it "makes sure a user can't delete another persons account" do
      hash = {"user" => @attrs}
      #This uses users 1 header
      user2 = FactoryGirl.create(:user_1)
      delete "/api/1/users/#{user2.id}", hash, @header
      expect(response.status).to eq(403) #ok
      expect(User.count).to eq(2)
    end
  end
end
#-#-#-#-#Serialization#-#-#-#-#
RSpec.describe User, :type => :request do
  describe "Serialization" do
    before(:example) do
      @user = FactoryGirl.create(:user_1)
      token = @user.tokens[0].auth_token
      @header = {::Settings.token_header => token, "Email" => @user.email, ::Settings.main_api_header => ::Settings.main_api_key}
    end
    # get /api/1/users
    it "checks only appropriate attributes are sent back for index" do
      FactoryGirl.create_list(:user_1, 10)
      get '/api/1/users', nil, @header
      expect(response.status).to eq(200) #ok
      expect(User.count).to eq(11)
      expect(::Arcadex::Token.count).to eq(11)
      expect(json["users"][0]["password_digest"]).to eq(nil)
      expect(json["users"][0]["created_at"]).to_not eq(nil)
      expect(json["users"][0]["updated_at"]).to_not eq(nil)
    end
  end
end
#-#-#-#-#Errors#-#-#-#-#
RSpec.describe User, :type => :request do
  describe "Authorization" do
    before(:example) do
      @user = FactoryGirl.create(:user_1)
      token = @user.tokens[0].auth_token
      @header = {::Settings.token_header => token, "Email" => @user.email, ::Settings.main_api_header => ::Settings.main_api_key}
    end
    it "checks for 404 response" do
      get "/api/1/users/#{@user.id + 10}", nil, @header
      expect(response.status).to eq(404) #not_found
    end
  end
end
#-#-#-#-#Collection Routes#-#-#-#-#
#-#-#-#-#Authentication#-#-#-#-#
RSpec.describe User, :type => :request do
  describe "Register" do
    before(:example) do
      @attrs = FactoryGirl.attributes_for(:user_1)
      @header = {::Settings.main_api_header => ::Settings.main_api_key}
    end
    # post /api/1/users/register
    it "checks response of a register request with a valid user object" do
      hash = {"user" => @attrs}
      post '/api/1/users/register', hash, @header
      expect(response.status).to eq(200) #ok
      expect(User.all.count).to eq(1)
      #A valid token needs to be returned
      expect(json["token"]["auth_token"]).to_not eq(nil)
      token = User.find(1).tokens[0]
      expect(json["token"]["auth_token"]).to eq(token.auth_token)
    end
    # post /api/1/users/register
    it "checks response of a register request with mismatched passwords" do
      @attrs["password"] = "password1"
      @attrs["password_confirmation"] = "password2"
      hash = {"user" => @attrs}
      post '/api/1/users/register', hash, @header
      expect(response.status).to eq(422) #invalid_resource
      expect(User.all.count).to eq(0)
      #Errors need to be returned
      expect(json["errors"]).to_not eq(nil)
    end
  end
end
RSpec.describe User, :type => :request do
  describe "Login" do
    before(:example) do
      @attrs = FactoryGirl.attributes_for(:user_1)
      @header = {::Settings.main_api_header => ::Settings.main_api_key}
    end
    # post /api/1/users/login
    it "checks response of a valid login request" do
      @attrs["password"] = "password123"
      @attrs["password_confirmation"] = "password123"   
      user = FactoryGirl.create(:user_1,@attrs)
      old_auth_token = user.tokens[0].auth_token
      hash = {"user" => @attrs}
      post '/api/1/users/login', hash, @header
      expect(response.status).to eq(200) #ok
      #A valid and new token need to be returned
      expect(json["token"]["auth_token"]).to_not eq(old_auth_token)
      #This token should be the newest token in the database
      new_auth_token = User.find(1).tokens.order("created_at").last.auth_token
      expect(json["token"]["auth_token"]).to eq(new_auth_token)
    end
    # post /api/1/users/login
    it "checks response of an invalid login request with an invalid password" do
      @attrs["password"] = "password123"
      @attrs["password_confirmation"] = "password123"   
      user = FactoryGirl.create(:user_1,@attrs)
      #The password needs to be invalid
      @attrs["password"] = "wrongPassword"
      hash = {"user" => @attrs}
      #It needs to send an email and password
      post '/api/1/users/login', hash, @header
      expect(response.status).to eq(401) #unauthorized
      #Errors need to be returned
      expect(json["errors"]).to_not eq(nil)
    end
    # post /api/1/users/facebook_login
    it "checks response of a valid facebook_login request" do

    end
  end
end
RSpec.describe User, :type => :request do
  describe "Logout" do
    before(:example) do
      @attrs = FactoryGirl.attributes_for(:user_1)
    end
    # get /api/1/users/1/logout
    it "checks logout response and makes sure token is deleted" do
      user = FactoryGirl.create(:user_1,@attrs)
      token = user.tokens[0].auth_token
      header = {::Settings.token_header => token, "Email" => user.email, ::Settings.main_api_header => ::Settings.main_api_key}
      post '/api/1/users/logout', nil, header
      expect(User.count).to eq(1)
      expect(response.status).to eq(200) #ok
      expect(::Arcadex::Token.count).to eq(0)
    end
  end
end