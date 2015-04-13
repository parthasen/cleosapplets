require_dependency "api/v1/application_controller"
require 'authorization'

class Api::V1::UsersController < Api::V1::ApplicationController

  skip_before_filter :authenticate_user, :only => [:register, :login, :facebook_login]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :index_authorize, only: [:index]
  before_action :show_authorize, only: [:show]
  before_action :update_authorize, only: [:update]
  before_action :destroy_authorize, only: [:destroy]
  before_action :register_authorize, only: [:register]
  before_action :login_authorize, only: [:login]
  before_action :logout_authorize, only: [:logout]

  # GET /api/1/users
  def index
    @users = ::User.all
    render json: @users, each_serializer: ::V1::UserSerializer
  end

  # GET /api/1/users/1
  def show
    render json: @user, serializer: ::V1::UserSerializer
  end

  # PATCH/PUT /api/1/users/1
  def update
    if @user.update(user_params)
      render json: @user, serializer: ::V1::UserSerializer
    else
      render :json => {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # DELETE /api/1/users/1
  def destroy
    @user.destroy
    render json: {}
  end

  # POST /api/1/users/register
  def register
    user = ::User.register(user_params)
    if user.errors.full_messages == []
      successful_login(user,user.tokens[0])
    else
      render :json => {errors: user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # POST /api/1/users/login
  def login
    user = ::User.login(user_params)
    if user
      token = user.tokens.create
      successful_login(user,token)
    else
      errors = "Email and/or Password is incorrect"
      render :json => {errors: errors}, status: :unauthorized
    end
  end

  # POST /api/1/users/facebook_login
  def facebook_login
    objHash = ::User.facebook_login(params,request)
    if objHash.nil?
      objHash = {error: "Could not retrieve the facebook user_id from your token"}
      render :json => objHash, status: :unauthorized
    else
      render :json => objHash
    end
  end

  # POST /api/1/users/logout
  def logout
    current_user.logout(current_token)
    render json: {}
  end

  private

    # Only allow a trusted parameter "white list" through.

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def set_user
      @user = ::User.find_by_id(params[:id])
      if @user.nil?
        render :json => {errors: "User was not found"}, status: :not_found
      end
    end

    def successful_login(user,token)
      ::Arcadex::Create.set_token(token,20000,request,nil)
      userHash = {id: user.id, username: user.username, email: user.email}
      tokenHash = {auth_token: token.auth_token}
      render :json => {user: userHash,token: tokenHash}
    end

    # Authorizations below here

    def index_authorize
      if !::Authorization::V1::User.index?(current_user)
        render :json => {errors: "User is not authorized for this action"}, status: :forbidden
      end
    end

    def show_authorize
      if !::Authorization::V1::User.show?(@user,current_user)
        render :json => {errors: "User is not authorized for this action"}, status: :forbidden
      end
    end

    def update_authorize
      if !::Authorization::V1::User.update?(@user,current_user)
        render :json => {errors: "User is not authorized for this action"}, status: :forbidden
      end  
    end

    def destroy_authorize
      if !::Authorization::V1::User.destroy?(@user,current_user)
        render :json => {errors: "User is not authorized for this action"}, status: :forbidden
      end  
    end

    def register_authorize
      if !::Authorization::V1::User.register?
        render :json => {errors: "User is not authorized for this action"}, status: :forbidden
      end
    end

    def login_authorize
      if !::Authorization::V1::User.login?
        render :json => {errors: "User is not authorized for this action"}, status: :forbidden
      end
    end

    def logout_authorize
      if !::Authorization::V1::User.logout?(current_user)
        render :json => {errors: "User is not authorized for this action"}, status: :forbidden
      end
    end
end
