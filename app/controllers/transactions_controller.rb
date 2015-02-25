class TransactionsController < ApplicationController
  before_action :set_trans, only: [:show, :edit, :update, :destroy]
  before_action :set_items_locs, only: [:show, :edit, :update, :destroy, :index]
  
  def new
      @transaction = Transaction.new
      @primary = Location.prime(current_user)
      @action = Action.find(params[:type])
      if params[:show]
        if params[:type] == '3' || params[:type] == '5'
        @show = Show.find(params[:show])
          check_user(@show.tour.group_id)
        @others = @primary.others(current_user)
        @items = Item.counted_in(@show) - Item.counted_out(@show)
        else
          redirect_to new_transaction_path(type:params[:type])
        end
      else
        @date = Date.today
        @items = Item.owned(current_user).active     
        @locations = Location.owned(current_user).active
      end
  end
  

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.show ? check_user(@transaction.show.tour.group_id) : ""
    @transaction.loc1 ? check_user(Location.find(@transaction.loc1).group_id) : ""
    @transaction.loc2 ? check_user(Location.find(@transaction.loc2).group_id) : ""
    check_user(@transaction.item.group_id)
    if @transaction.save
        if @transaction.show
          redirect_to show_path(@transaction.show), notice: "Transaction Saved"
        else
          redirect_to root_path, notice: 'Transaction Saved'
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
    params.require(:transaction).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2,:show_id)
  end
         
 
  def set_trans
    @transaction = Transaction.find(params[:id])
    check_user(@transaction.item.group_id)
  end
  
  def set_items_locs
    @items = Item.owned(current_user).active
    @locations = Location.owned(current_user).active
  end


end
