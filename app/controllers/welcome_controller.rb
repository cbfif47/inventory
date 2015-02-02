class WelcomeController < ApplicationController
  def index
    @locations = Location.owned(current_user)
    @items = Item.owned(current_user)
    @show = Show.owned(current_user).where(date: Date.today).first
    @shows = Show.hascounts(current_user)
    @next = Show.owned(current_user).where("date > ?", @shows.first.date).order(:date).first
  end
end
