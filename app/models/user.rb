require 'type_cartographer'

class User < ActiveRecord::Base
  include IdentityCache
  
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_validation :sanitize_attributes
  after_create :setup_user

	has_secure_password

  has_many :tokens, :as => :imageable, :class_name => "::Arcadex::Token", dependent: :destroy

  validates :username, presence: true, :uniqueness => { :case_sensitive => false }
  #validates_format_of :username, :with => /\A[A-Za-z0-9\d]+\Z/i
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  #Might need a regex for emails, or just rather confirm them

  def sanitize_attributes
    return true
  end

  def setup_user
  	create_token
    return true
  end

  def create_token
    self.tokens.create!
    return true
  end

  def self.register(user_params)
    user = self.new(user_params)
    user.save
    return user
  end

  #Should use one or the other for login

  def self.login(user_params)
    email = user_params[:email]
    if email
      email = email.downcase
    end
    user = self.find_by(email: email)
    if user && user.authenticate(user_params[:password])
      return user
    else
      return nil
    end
  end

  def self.facebook_login(params,request)
    short_token = params[:token]
    fb_api = Facebook.new
    long_token = fb_api.get_long_token(short_token)
    fb_user_id = Facebook.get_id(fb_api,long_token,short_token)
    if fb_user_id.nil?
      #Couldn't retrieve the facebook user_id from token
      return nil;
    end
    @user = User.find_by(fb_user_id: fb_user_id)
    if @user.nil?
      #Create new user
      password = ::Devise.friendly_token
      params = {username: "user#{fb_user_id}", email: "#{fb_user_id}@email.com",
        fb_user_id: fb_user_id, password: password, password_confirmation: password}
      @user = User.create(params)
      @api_token = @user.tokens[0]
    else
      #Log in a user
      @api_token = @user.tokens.create
    end
    ::Arcadex::Create.set_token(@api_token,20000,request,nil)
    userHash = {id: @user.id, username: @user.username, fb_user_id: @user.fb_user_id}
    objHash = {user: userHash, api_token: @api_token.auth_token, fb_token: long_token}
    return objHash
  end

  def logout(token)
    token.destroy
  end

end
