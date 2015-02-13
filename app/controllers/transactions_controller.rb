class TransactionsController < ApplicationController
  before_action :set_trans, only: [:show, :edit, :update, :destroy]
  before_action :set_items_locs, only: [:show, :edit, :update, :destroy, :index]
  
  def new
      @transaction = Transaction.new
      @items = Item.owned(current_user).active
      @locations = Location.owned(current_user).active
      @primary = Location.primary(current_user)
      @action = Action.find(params[:type])
      if params[:show]
        @show = Show.find(params[:show])
        @date = @show.date        
      else
        @date = Date.today
      end
  end
  

  def create
  @transaction = Transaction.new(transaction_params)
    if @transaction.save
        if @transaction.show
          redirect_to show_path(@transaction.show)
        else
        redirect_to action: 'index'
        end
      else
            render 'new'
    end

  end 
  
  def show
  end
    
  def edit
  end
    
  def update
    if @transaction.update(transaction_params)
            redirect_to action: 'index'
                    else
            render 'edit'
    end
  end
    
  def index
    @transactions = Transaction.owned(current_user).paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
    @transaction.destroy        
    redirect_to transactions_path
  end

    
private
  def transaction_params
    params.require(:transaction).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2,:show_id).merge(group_id: current_user.group_id)
  end
         
 
  def set_trans
    @transaction = Transaction.find(params[:id])
    check_user(@transaction)
  end
  
  def set_items_locs
    @items = Item.owned(current_user).active
    @locations = Location.owned(current_user).active
  end


end
