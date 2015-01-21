class ReportsController < ApplicationController
    def summary
      @locations = Location.where(:active => true, :group_id =>current_user.group_id)
      @items = Item.where(:active => true, :group_id =>current_user.group_id)


    end
    
    def by_sub
      @locations = Location.where(:active => true, :group_id => current_user.group_id)
      @subs = Item.where(group_id: current_user.group_id, active: true).uniq.pluck(:sub)
    end
    
    def index
        end
end
