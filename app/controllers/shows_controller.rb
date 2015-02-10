class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]


  def index
    @shows = Show.owned(current_user)
  end

  def show
    redirect_to counts_path(@show.id)
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
  end

  def update
    @show.update(show_params)
  end

  def destroy
    @show.destroy
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
