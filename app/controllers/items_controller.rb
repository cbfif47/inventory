class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def new
      @item = Item.new
  end

  def create
      @item = Item.new(item_params)
        if @item.save
            redirect_to action: 'index'
        else
            render 'new'
        end
  end

  def show
  end
    
  def edit
  end
    
  def update
        if @item.update(item_params)
            redirect_to action: 'index'
                    else
            render 'edit'
        end
  end
    
  def index
    @items = Item.owned(current_user).active
    @inactives = Item.owned(current_user).inactive
  end


  def delete
  end
    
  private
    def item_params
      params.require(:item).permit(:name,:sub,:active,:rate,:soft).merge(group_id: current_user.group_id)
    end

  
    def set_item
      @item = Item.find(params[:id])
      check_user(@item.group_id)
    end
end
