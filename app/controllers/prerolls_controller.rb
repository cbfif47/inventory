class PrerollsController < ApplicationController
  def edit
      @preroll = Preroll.find_by id: 1
  end
    
  def update
      @preroll = Preroll.find_by id: 1
      
      if @preroll.update(preroll_params)
          if @preroll.action_id == 1
              redirect_to new_batch_path
              else
              redirect_to new_transaction_path
          end
      end
  end
    
    private
    def preroll_params
        params.require(:preroll).permit(:date, :action_id, :loc1, :loc2)
    end
    
end
