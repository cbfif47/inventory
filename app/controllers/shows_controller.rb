class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @shows = Show.all
    respond_with(@shows)
  end

  def show
    respond_with(@show)
  end

  def new
    @show = Show.new
    respond_with(@show)
  end

  def edit
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
      params.require(:show).permit(:date, :venue)
    end
  
    def check_user(object)
      unless object.group_id == current_user.group_id
        flash[:error] = "Quit sneaking around, this aint yours!"
        redirect_to root_url # halts request cycle
      end
  end 
end
