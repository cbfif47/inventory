class WelcomeController < ApplicationController
  def index
    @locations = Location.owned(current_user)
    @items = Item.owned(current_user)
    @shows = Show.hascounts(current_user)
    @latest = Show.find_by(Show.joins(:counts).where(counts:{out:false}).maximum(:date))
    @outstanding = Item.counted_in(@latest) - Item.counted_out(@latest)
    @next = Show.where("date > ?", @latest.date).order(:date).first
  end
end
