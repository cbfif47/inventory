class TransactionsController < ApplicationController

    
def new
      @transaction = Transaction.new
      @preroll = Preroll.where(:group_id => current_user.group_id).first
      @items = Item.where('active = ? AND group_id = ?', true, current_user.group_id)
      @locations = Location.where("active = ? AND id != ? AND group_id = ?",true, @preroll.loc1, current_user.group_id)


end

# def create
#        @transaction = Transaction.new(transaction_params)
#        
#        if @transaction.save
#            redirect_to action: 'index'
#        else
#            render 'new'
#        end
#end

  def create
    @preroll = Preroll.where(:group_id => current_user.group_id).first
    params['transaction'].each do |k,v|
        if k['quantity'] != ''
          if @preroll.action_id == 4 #adjustment logic
            if k['quantity'].to_i > k['oldquant'].to_i
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => (k['quantity'].to_i-k['oldquant'].to_i), :loc1 => 1, :loc2 => k['loc1'], :group_id => current_user.group_id)
              @transaction.save
            else
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => (k['oldquant'].to_i-k['quantity'].to_i), :loc1 => k['loc1'], :loc2 => 1, :group_id => current_user.group_id)
              @transaction.save
            end
          else
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => k['quantity'], :loc1 => k['loc1'], :loc2 => k['loc2'], :group_id => current_user.group_id)
              @transaction.save
          end
        else
        end
    end    
    redirect_to action: 'index'
end 
  
def show
    @transaction = Transaction.find(params[:id])
end
    
def edit
    @transaction = Transaction.find(params[:id])
end
    
def update
    @transaction = Transaction.find(params[:id])
        
        
    if @transaction.update(transaction_params)
            redirect_to action: 'index'
                    else
            render 'edit'
    end
end
    
  def index
    @transactions = Transaction.where(:group_id => current_user.group_id)
    @locations = Location.where("group_id = ? OR id = ?", current_user.group_id, 1)
    @formlocs = Location.where(:group_id => current_user.group_id)
    @items = Item.where(:active => true, :group_id => current_user.group_id) 
    if   Preroll.where(:group_id => current_user.group_id).first
          @preroll = Preroll.where(:group_id => current_user.group_id).first
        else @preroll = Preroll.new
        end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
        
    redirect_to transactions_path
  end

  def  edit_all
    @locations = Location.where(:group_id => current_user.group_id)
    @transactions = Transaction.where(:group_id => current_user.group_id)
    @items = Item.where(:active => true, :group_id => current_user.group_id) 
  end
  
    
  def update_all
    params['transaction'].keys.each do|id|
          @transaction = Transaction.find(id.to_i)
          @transaction.update_attributes(transactions_params(id))
        end
    redirect_to transactions_path
  end
    
#  def  new_batch
#    @preroll = Preroll.where(:group_id => current_user.group_id).first
#    @location = Location.where("available = ? AND group_id", true).first
#    @items = Item.where(:active => true)       
#  end
  
    
   
    
private
    def transaction_params
            params.require(:transaction).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2).merge(group_id: current_user.group_id)
    end
          
    def transactions_params(id)
params.require(:transaction).fetch(id).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2).merge(group_id: current_user.group_id)
    end
 

end
