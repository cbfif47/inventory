class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tours = Tour.owned(current_user)
    respond_with(@tours)
  end

  def show
    @shows = Show.owned(current_user).ontour(@tour)
  end

  def new
    @tour = Tour.new
  end

  def edit
  end

  def create
    @tour = Tour.new(tour_params)
    @tour.save
    redirect_to tour_path(@tour)
  end

  def update
    @tour.update(tour_params)
    respond_with(@tour)
  end

  def destroy
    @tour.destroy
    respond_with(@tour)
  end

  private
    def set_tour
      @tour = Tour.find(params[:id])
      check_user(@tour.group_id)
    end

    def tour_params
      params.require(:tour).permit(:name,shows_attributes: [:id,:date,:venue,:city,:_destroy]).merge(group_id: current_user.group_id)
    end
end
