class CountsController < ApplicationController
  before_action :set_count, only: [:show, :edit, :update, :destroy]

  def new
      @show = Show.find(params[:show_id])
    check_user(@show.tour.group_id)
      session[:return_to] = request.referer
      @count = Count.new
      @primary = Location.prime(current_user)
    if params[:direction] == "in"
      @items = Item.where(id:(Item.owned(current_user).active.pluck(:id) - Item.counted_in(@show).pluck(:id))).order(:name,:sub)
    else
      @items = Item.where(id:(Item.counted_in(@show).pluck(:id) - Item.counted_out(@show).pluck(:id))).order(:name,:sub)      
    end

  end

  def create
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
    redirect_to new_show_count_path(@show, direction:@direction), :notice => 'Count Destroyed'
  end

  private
    def set_count
      @count = Count.find(params[:id])
      check_user(@count.show.tour.group_id)
    end
  
    def set_items
    
    end

    def count_params
      params.require(:count).permit(:show_id, :item_id, :quantity, :out, :rate)
    end
end
