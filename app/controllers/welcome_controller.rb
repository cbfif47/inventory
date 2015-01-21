class WelcomeController < ApplicationController
  def index
        if   Preroll.where(:group_id => current_user.group_id).first
          @preroll = Preroll.where(:group_id => current_user.group_id).first
        else @preroll = Preroll.new
        end
    @locations = Location.where(:active => true, :group_id => current_user.group_id) 
    @items = Item.where(:active => true, :group_id => current_user.group_id) 
  end
end
