class ItemsController < ApplicationController
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
    @item = Item.find(params[:id])
end
    
    def edit
        @item = Item.find(params[:id])
    end
    
    def update
        @item = Item.find(params[:id])
        
        
        if @item.update(item_params)
            redirect_to action: 'index'
                    else
            render 'edit'
        end
    end
    
  def index
    @items = Item.where(:group_id => current_user.group_id)  
  end


  def delete
  end
    
    private
    def item_params
      params.require(:item).permit(:name,:sub,:active).merge(group_id: current_user.group_id)
    end
    
end
