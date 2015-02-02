class CountsController < ApplicationController
  before_action :set_count, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @show = Show.find(params[:id])
    check_user(@show)
    @counts = Count.where(:show_id => params[:id], out:false).owned(current_user).includes(:item)
    @mostrecentcount = Count.owned(current_user).order(id: :desc).first
    @islatest = @mostrecentcount.present? ? @mostrecentcount.show.date <= @show.date : true
    @items = Item.where(id:(Item.owned(current_user).active.pluck(:id) - Item.counted_in(@show).pluck(:id)))
    @outids = Item.counted_in(@show).pluck(:id) - Item.counted_out(@show).pluck(:id)
      @needouts = Item.where(id:@outids).order(:name,:sub)
  end

  def show
    respond_with(@count)
  end

  def new
      @show = Show.find(params[:id])
      check_user(@show)
      session[:return_to] = request.referer
      @count = Count.new
      @items = Item.where(id:(Item.owned(current_user).active.pluck(:id) - Item.counted_in(@show).pluck(:id))).order(:name,:sub)
      @primary = Location.primary(current_user)
      @outids = Item.counted_in(@show).pluck(:id) - Item.counted_out(@show).pluck(:id)
      @needouts = Item.where(id:@outids).order(:name,:sub)
  end

  def edit
  end

  def create
    @show = Show.find(params[:id])
    if Count.make_batch(params['count'], current_user)
      redirect_to session.delete(:return_to), :notice => 'Counts created!'
    else
      redirect_to action: 'new'
    end
  end

  def update    
    @count.update(count_params)
    respond_with(@count)
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

    def count_params
      params.require(:count).permit(:show_id, :item_id, :in, :out)
    end
end
