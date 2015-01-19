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
  
    def self.remain(item, location)
        self.where(:item_id => item, :loc2 => location).sum(:quantity) - self.where(:item_id => item, :loc1 => location).sum(:quantity)
            
    end
    
    def self.subrpt(sub, location)
      self.joins(:item).where('items.sub' => sub, transactions:{ :loc2 => location.id}).sum(:quantity) - self.joins(:item).where('items.sub' => sub, transactions:{ :loc1 => location.id}).sum(:quantity)
    end
    
    def self.avgitem(item)
        if where(:item_id => item, :action_id => 1).count > 0
        where(:item_id => item, :action_id => 1).average(:quantity)
        else
            return 0
        end
    end
    
    def self.avgsub(sub)
      if joins(:item).where('items.sub' => sub, :action_id => 1).count > 0
        joins(:item).where('items.sub' => sub, :action_id =>1).average(:quantity)
        else
            return 0
        end
    end
    
    def self.goneitem(item)
        if self.avgitem(item) == 0
            return 0
        else
          (self.remain(item, @primary) / self.avgitem(item)).round(2)
        end
    end
    
    def self.gonesub(sub)
        if self.avgsub(sub) == 0
            return 0
        else
        (self.subrpt(sub, @primary) / self.avgsub(sub)).round(2)
        end
    end
    
end
