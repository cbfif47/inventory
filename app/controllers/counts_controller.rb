class CountsController < ApplicationController
  before_action :set_count, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @counts = Count.all
    respond_with(@counts)
  end

  def show
    respond_with(@count)
  end

  def new
      @count = Count.new
      @show = Show.find(params[:id])
      @ids = Item.owned(current_user).active.pluck(:id) - Item.counted(@show).pluck(:id)
    @items = Item.where(id:@ids) 
      @primary = Location.primary(current_user)
  end

  def edit
  end

  def create
    if Count.make_batch(params['count'])
    redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end

  def update
    @count.update(count_params)
    respond_with(@count)
  end

  def destroy
    @count.destroy
    respond_with(@count)
  end

  private
    def set_count
      @count = Count.find(params[:id])
    end

    def count_params
      params.require(:count).permit(:show_id, :item_id, :in, :out)
    end
end
