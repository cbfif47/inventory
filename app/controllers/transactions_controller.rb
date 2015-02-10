class TransactionsController < ApplicationController
  before_action :set_trans, only: [:show, :edit, :update, :destroy]
  before_action :set_items_locs, only: [:show, :edit, :update, :destroy, :index]
  
  def new
      @transaction = Transaction.new
      @items = Item.owned(current_user).active
      @otherlocs = Location.owned(current_user).active.where("id != ?", @preroll.loc1)
  end
  
  def comp_new
    @transaction = Transaction.new
    @show = Show.find(params[:id])
    @items = Item.where(id:(Item.counted_in(@show).pluck(:id) - Item.counted_out(@show).pluck(:id))).order(:name,:sub)      
  end

  def comp_create
    @count = Count.find(params[:id])
    @primary = Location.primary(current_user)
    @transaction = Transaction.new(transaction_params.merge(:count_id => @count.id, :item_id => @count.item_id, :date => @count.show.date, :loc1 => @primary.id, :loc2 => 1, :action_id => 1))
            if @transaction.save
            redirect_to action: 'index'
        else
            render 'new'
        end
  end

  def create
    params['transaction'].each do |k,v|
    Transaction.make_batch(k,v, current_user)
    end
    redirect_to action: 'index'

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

  def  edit_all
    @locations = Location.where("group_id = ? OR id = ?", current_user.group_id, 1)
    @transactions = Transaction.owned(current_user)
    @items = Item.owned(current_user).active
  end
  
    
  def update_all
    params['transaction'].keys.each do|id|
          @transaction = Transaction.find(id.to_i)
          @transaction.update_attributes(transactions_params(id))
        end
    redirect_to transactions_path
  end
    
private
  def transaction_params
   params.require(:transaction).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2).merge(group_id: current_user.group_id)
  end
          
  def transactions_params(id)
params.require(:transaction).fetch(id).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2).merge(group_id: current_user.group_id)
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
