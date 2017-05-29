class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  helper_method :current_chef, :logged_in?  # makes these methods available to our views.
  
  def current_chef
    # define the current chef based on the session
    # "or-equals" returns itself or, if self doesn't exist, returns the other thing.
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def logged_in?
    !!current_chef
    # bangs turn anything into a true/false.
    # this just checks if there's a current user returned from the method above.
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
end
