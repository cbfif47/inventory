class PrerollsController < ApplicationController
  def edit
      @preroll = Preroll.where(:group_id => current_user.group_id).first
  end
    
  def update
    @preroll = Preroll.where(:group_id => current_user.group_id).first
      if @preroll.update(preroll_params)
          if @preroll.action_id == 1
              redirect_to new_transaction_path
              else
              redirect_to new_transaction_path
          end
      end
  end
  
  def create
    @preroll = Preroll.new(preroll_params)
    if @preroll.save
              redirect_to new_transaction_path
          end
      
  end
    
    private
    def preroll_params
        params.require(:preroll).permit(:date, :action_id, :loc1, :loc2,:group_id)
    end
    
end
