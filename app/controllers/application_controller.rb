class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    before_action :authenticate_user!
  
     def check_user(object)
    unless object == current_user.group_id
      flash[:error] = "Quit sneaking around, this aint yours!"
      redirect_to root_url # halts request cycle
    end
  end 
  
    
  def incoming_date(subject) #try a bunch of different things to see what sticks, cant do %Y cuz it'll do 0015 as year
    @date = Date.strptime(subject, '%m/%d/%y') rescue nil
    if !@date
      @date = Date.strptime(subject, '%m-%d-%y') rescue nil
    end
    if !@date
      @date = Date.strptime(subject, "%m/%d") rescue nil
    end
    if !@date
      @date = Date.strptime(subject, "%m-%d") rescue nil
    end
    @date
  end
  
end
