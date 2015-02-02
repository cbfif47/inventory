class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @shows = Show.owned(current_user)
    respond_with(@shows)
  end

  def show
    redirect_to counts_path(@show.id)
  end

  def new
    @show = Show.new
    @tours = Tour.where(:group_id => current_user.group_id)
    respond_with(@show)
  end

  def edit
    @tours = Tour.where(:group_id => current_user.group_id)
  end

  def create
    @show = Show.new(show_params)
    @show.save
    respond_with(@show)
  end

  def update
    @show.update(show_params)
    respond_with(@show)
  end

  def destroy
    @show.destroy
    respond_with(@show)
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
