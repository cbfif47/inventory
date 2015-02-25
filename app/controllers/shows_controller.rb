class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  #http_basic_authenticate_with :name => "user", :password => "mypass", :only => :incoming
  
  def index
    @shows = Show.owned(current_user).relevant
    @older = Show.owned(current_user).irrelevant
  end

  def show
    @show = Show.find(params[:id])
    check_user(@show.tour.group_id)
    @guests = Guest.where(show_id:params[:id])
    @guestlist = @guests.collect do |guest|
      guest.name
    end
    @countins = Count.where(show_id:@show.id, out:false).includes(:item)
    @latest = Show.owned(current_user).hascounts.maximum(:date)
    @islatest = @latest.present? ? @latest <= @show.date : true 
    @total = 0
        @stots = 0
    if @islatest #only need this junk if show is eligible for counts
      @in_items = @countins.pluck(:item_id) 
      @needins = Item.owned(current_user).active.pluck(:id) - @in_items 
      if @countins.present? #if nothing's been counted in, then we can't count anything out. Verify that present works
        @needouts = @in_items - Item.counted_out(@show).pluck(:id) 
        @primary = Location.prime(current_user)
        
      end
    end
  end

  def new
    @show = Show.new
    @tours = Tour.where(:group_id => current_user.group_id)
  end

  def edit
    @tours = Tour.where(:group_id => current_user.group_id)
    if @show.guests.blank?
      @show.guests.build
    end
  end

  def create
    @show = Show.new(show_params)
    @show.save
    redirect_to action: 'index'
  end

  def update
    @show.update(show_params)
    redirect_to show_path(@show)
  end

  def destroy
    @show.destroy
    redirect_to action:"index"
  end

  private
    def set_show
      @show = Show.find(params[:id])
      check_user(@show.tour.group_id)
    end

    def show_params
      params.require(:show).permit(:date, :venue, :city, :tour_id,:notes, guests_attributes:[:id,:name,:plus,:special,:_destroy])
    end
  
  #def incoming_params
   # params.require(envelope:[:from]).permit(headers:['Subject'],:plain)
 # end
  
end
