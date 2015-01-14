class PrerollsController < ApplicationController
  def edit
      @preroll = Preroll.find_by id: 1
  end
    
  def update
      @preroll = Preroll.find_by id: 1
      
      if @preroll.update(preroll_params)
          redirect_to new_transaction_path
      end
  end
    
    private
    def preroll_params
        params.require(:preroll).permit(:date, :action_id, :loc1, :loc2)
    end
    
end
