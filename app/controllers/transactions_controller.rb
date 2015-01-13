class TransactionsController < ApplicationController
  def new
      @transaction = Transaction.new
  end

def create
        @transaction = Transaction.new(transaction_params)
        
        if @transaction.save
            redirect_to action: 'index'
        else
            render 'new'
        end
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

  end


  def delete
  end
  
  def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy
        
        redirect_to transactions_path
  end
    
    private
    def transaction_params
        params.require(:transaction).permit(:date,:item_id,:action_id,:quantity,:loc1,:loc2)
    end
    
end
