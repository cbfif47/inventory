class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    before_action :authenticate_user!
  
     def check_user(object)
    unless object.group_id == current_user.group_id
      flash[:error] = "Quit sneaking around, this aint yours!"
      redirect_to root_url # halts request cycle
    end
  end 
  
end
