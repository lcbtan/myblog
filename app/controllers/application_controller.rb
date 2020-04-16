class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    # Helper method to determine if someone is logged-in
    def logged_in?
      !session[:email].nil?
    end
    
    # Returns true if someone is logged-in, else redirects
    # to the login page
    def logged_in_user
      unless logged_in?
        flash[:errors] = "Please log-in first."
        redirect_to root_path
      end
    end

    # Helper method that returns the currently logged-in
    # user as a User object
    def current_user
      User.where(email: session[:email]).first
    end    
end
