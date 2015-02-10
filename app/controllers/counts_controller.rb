class CountsController < ApplicationController
  before_action :set_count, only: [:show, :edit, :update, :destroy]

  def index
    @show = Show.find(params[:id])
    check_user(@show)
    @counts = Count.where(show_id:@show.id, out:false).owned(current_user).includes(:item)
    @mostrecentcount = Count.owned(current_user).order(id: :desc).first
    @islatest = @mostrecentcount.present? ? @mostrecentcount.show.date <= @show.date : true
    @items = Item.owned(current_user).active.pluck(:id) - Item.counted_in(@show).pluck(:id)
    @needouts = Item.counted_in(@show).pluck(:id) - Item.counted_out(@show).pluck(:id)
  end

  def new
      @show = Show.find(params[:id])
      check_user(@show)
      session[:return_to] = request.referer
      @count = Count.new
      @primary = Location.primary(current_user)
    if params[:direction] == "in"
      @items = Item.where(id:(Item.owned(current_user).active.pluck(:id) - Item.counted_in(@show).pluck(:id))).order(:name,:sub)
    else
      @items = Item.where(id:(Item.counted_in(@show).pluck(:id) - Item.counted_out(@show).pluck(:id))).order(:name,:sub)      
    end

  end

  def create
    @show = Show.find(params[:id])
    if Count.make_batch(params['count'], current_user)
      redirect_to session.delete(:return_to), :notice => 'Counts created!'
    else
      redirect_to action: 'new'
    end
  end

  def destroy
    @show = Show.find_by(id: @count.show_id)
    @direction = @count.out? ? "out" : "in"
    @count.destroy
    redirect_to count_in_out_path(@show, @direction), :notice => 'Count Detroyed'
  end

  private
    def set_count
      @count = Count.find(params[:id])
      check_user(@count)
    end
  
    def set_items
    
    end

    def count_params
      params.require(:count).permit(:show_id, :item_id, :quantity, :out, :rate)
    end
end
