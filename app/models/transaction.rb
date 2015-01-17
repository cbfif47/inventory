class Transaction < ActiveRecord::Base
  belongs_to :item
  belongs_to :action
    @primary = Location.where(:available => true).first
    
    def net
        if quantity 
            quantity * action.impact 
        else
        0
        end
    end
    
    def self.sumrpt(item, locno, location)
        where(:item_id => item, locno => location.id).sum(:quantity)
            
    end
    
    def self.subrpt(sub, locno, location)
        joins(:item).where('items.sub' => sub, transactions:{ locno => location.id}).sum(:quantity)
    end
    
    def self.avgitem(item)
        if where(:item_id => item, :action_id => 1).count > 0
        where(:item_id => item, :action_id => 1).average(:quantity)
        else
            return 0
        end
    end
    
    def self.avgsub(sub)
        if joins(:item).where('items.sub' => sub).count > 0
        joins(:item).where('items.sub' => sub).average(:quantity)
        else
            return 0
        end
    end
    
    def self.goneitem(item)
        if self.avgitem(item) == 0
            return 0
        else
        ((self.sumrpt(item, :loc2, @primary) - self.sumrpt(item, :loc1, @primary))/self.avgitem(item)).round(2)
        end
    end
    
    def self.gonesub(sub)
        if self.avgsub(sub) == 0
            return 0
        else
        ((self.subrpt(sub, :loc2, @primary) - self.subrpt(sub, :loc1, @primary))/self.avgsub(sub)).round(2)
        end
    end
    
end
