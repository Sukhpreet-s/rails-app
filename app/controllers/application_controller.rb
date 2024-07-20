class ApplicationController < ActionController::Base
    private
        def current_user
            @_current_user ||= session[:user_id] && 
                User.find_by(id: session[:user_id])
        end

        helper_method :current_user

        def require_login
            unless current_user.present?
                flash[:alert] = "Please log in or sign up to access the superpower to access this section"
                redirect_to login_path
            end
        end
end
