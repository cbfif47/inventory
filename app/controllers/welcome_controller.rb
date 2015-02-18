class WelcomeController < ApplicationController
  def index
    @locations = Location.owned(current_user).count # has group set up their stuff?
    @items = Item.owned(current_user).count         # if not we'll tell them to in the view 
    @shows = Show.owned(current_user).count         #
    @tours = Tour.owned(current_user).count         #
    @counts = Show.hascounts(current_user).count    # Have they counted anything in yet?
    if @counts > 0 # If they have, then lets pull the info on their latest shows, if they have one in progress, etc
      @latest = Show.find_by(date:(Show.hascounts(current_user).maximum(:date)))
      @outstanding = Item.counted_in(@latest) - Item.counted_out(@latest)
      if @outstanding.any?
        @primary = Location.prime(current_user) #only using it for label of the transfer button during a show, ie only if outstanding
      else
        @next = Show.where("date > ?", @latest.date).order(:date).first #only needed if not outstanding
      end
    else ###### Do i need to add a check to make sure they have a show?
      @next = Show.owned(current_user).order(:date).first #if they havent counted, what's going to be their first show?
    end
  end
end
