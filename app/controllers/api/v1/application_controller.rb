class Api::V1::ApplicationController < ::ActionController::API

  before_action :authenticate_app
  before_action :authenticate_user

  private

    def authenticate_app
      api_key = ::Arcadex::Header.grab_param_header(params,request,::Settings.main_api_header,false)
      if api_key.nil? || api_key != ::Settings.main_api_key
        render :json => {errors: "App is not authorized"} , status: :forbidden
      end
    end

    def authenticate_user
      set_hash
      if @instance_hash.nil?
        response.headers["Logged-In-Status"] = "false"
        render :json => {errors: "User is not logged in, register or log in"} , status: :unauthorized
      else
        response.headers["Logged-In-Status"] = "true"
      end
    end

    def set_hash
      @instance_hash = ::Arcadex::Authentication.get_instance_no_update(params,request,::Settings.token_header)
    end

    def current_user
      if !@instance_hash.nil?
        return @instance_hash["current_owner"]
      else
        return nil
      end
    end

    def current_token
      if !@instance_hash.nil?
        return @instance_hash["current_token"]
      else
        return nil
      end
    end
    
end