class WelcomeController < ApplicationController
  def index
    @locations = Location.owned(current_user)
    @items = Item.owned(current_user)
    @shows = Show.hascounts(current_user)
    if @shows.any?
    @next = Show.owned(current_user).where("date > ?", @shows.first.date).order(:date).first
    else
      @next = @shows
    end
  end
end
