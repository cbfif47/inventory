class ReportsController < ApplicationController
    def summary
      @locations = Location.where(:active => true)
      @items = Item.where(:active => true)
    end
    
    def by_sub
      @locations = Location.where(:active => true)
      @subs = Item.uniq.pluck(:sub)
    end
    
    def index
        end
end
