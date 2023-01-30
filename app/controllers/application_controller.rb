class ApplicationController < ActionController::Base

private
 
    def require_signin 
        unless  current_user 
           session[:intended_url] = request.url
           redirect_to new_session_path, alert: "Please Sign in first!" 
        end
    end


    def current_user
        ##memoization.  unless current user nil find user with session cookie 
        ##store in instance var to avoid calling multiple times
        @current_user ||= User.find(session[:user_id]) if session[:user_id]

        end
    
    helper_method :current_user


    def current_user?(user)
        #is user being requested the same as the user loged in
        current_user == user || current_user_admin?
    end

    helper_method :current_user?


    def require_admin
        unless current_user_admin?
            redirect_to root_url, alert: "Unauthorized access!"
          end
    end
    
    def current_user_admin?
        current_user && current_user.admin?
    end

    helper_method :current_user_admin?

   
    
end


