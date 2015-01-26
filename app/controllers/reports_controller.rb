class ReportsController < ApplicationController
    def summary
      @locations = Location.owned(current_user).active
      @items = Item.owned(current_user).active


    end
    
    def by_sub
      @locations = Location.owned(current_user).active
      @subs = Item.owned(current_user).active.uniq.pluck(:sub)
    end
    
    def index
        end
end
