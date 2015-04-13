class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  protected

    def authenticate_admin_user!
      if ::Defcon.authenticate_admin_user!(session)
        return true
      else
        redirect_to defcon.defcon_login_path, alert: "Login!"
        return false
      end
    end

    def current_admin_user
      return ::Defcon.current_admin_user(session)
    end

end
