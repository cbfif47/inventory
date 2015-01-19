class TransactionsController < ApplicationController

    
def new
      @transaction = Transaction.new
      @preroll = Preroll.find_by id: 1
      @items = Item.where('active = ?', true)
      @locations = Location.where("active = ? AND id != ?",true, @preroll.loc1)


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
    @preroll = Preroll.find_by id: 1
    params['transaction'].each do |k,v|
        if k['quantity'] != ''
          if @preroll.action_id == 4 #adjustment logic
            if k['quantity'].to_i > k['oldquant'].to_i
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => (k['quantity'].to_i-k['oldquant'].to_i), :loc1 => 1, :loc2 => k['loc1'])
              @transaction.save
            else
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => (k['oldquant'].to_i-k['quantity'].to_i), :loc1 => k['loc1'], :loc2 => 1)
              @transaction.save
            end
          else
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => k['quantity'], :loc1 => k['loc1'], :loc2 => k['loc2'])
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
    @transactions = Transaction.all
    @locations = Location.all
    @preroll = Preroll.find_by id: 1
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
        
    redirect_to transactions_path
  end

  def  edit_all
    @transactions = Transaction.all
  end
  
    
  def update_all
    params['transaction'].keys.each do|id|
          @transaction = Transaction.find(id.to_i)
          @transaction.update_attributes(transactions_params(id))
        end
    redirect_to transactions_path
  end
    
  def  new_batch
    @preroll = Preroll.find_by id: 1
    @location = Location.where("available = ?", true).first
    @items = Item.where(:active => true)       
  end
  
    
   
    
private
    def transaction_params
        params.require(:transaction).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2)
    end
          
    def transactions_params(id)
        params.require(:transaction).fetch(id).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2)
    end
 

end
