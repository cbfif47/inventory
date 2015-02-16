class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]


  def index
    @shows = Show.owned(current_user)
  end

  def show
    @show = Show.find(params[:id])
    check_user(@show)
    @countins = Count.where(show_id:@show.id, out:false).owned(current_user).includes(:item)
    @mostrecentcount = Count.owned(current_user).order(id: :desc).first
    @islatest = @mostrecentcount.present? ? @mostrecentcount.show.date <= @show.date : true
    @needins = Item.owned(current_user).active.pluck(:id) - Item.counted_in(@show).pluck(:id)
    @needouts = Item.counted_in(@show).pluck(:id) - Item.counted_out(@show).pluck(:id)
  end

  def new
    @show = Show.new
    @tours = Tour.where(:group_id => current_user.group_id)
  end

  def edit
    @tours = Tour.where(:group_id => current_user.group_id)
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
      check_user(@show)
    end

    def show_params
      params.require(:show).permit(:date, :venue, :tour_id).merge(group_id: current_user.group_id)
    end
  
end
