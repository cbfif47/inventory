class WelcomeController < ApplicationController
  def index
    @locations = Location.owned(current_user).count
    @items = Item.owned(current_user).count
    @shows = Show.owned(current_user).count
    @tours = Tour.owned(current_user).count
    @counts = Show.hascounts(current_user).count
    if @counts > 0
      @latest = Show.find_by(date:(Show.hascounts(current_user).maximum(:date)))
      @outstanding = Item.counted_in(@latest) - Item.counted_out(@latest)
      @next = Show.where("date > ?", @latest.date).order(:date).first
      @primary = Location.prime(current_user)
    else
      @next = Show.owned(current_user).order(:date).first
    end
  end
end
