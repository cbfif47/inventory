class Transaction < ActiveRecord::Base
  include Ownable
  belongs_to :item
  belongs_to :action
  belongs_to :count
  belongs_to :show
  
  scope :active, -> {where("active = ?", true)}
    
  
    def net
        if quantity 
            quantity * action.impact 
        else
        0
        end
    end
  
  def self.remain(item, location)
    self.where("item_id = ? AND loc2 = ?", item, location).sum(:quantity) - self.where("item_id = ? AND loc1 = ?", item, location).sum(:quantity)
            
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
  
  def self.make_batch(k,v, user, count="")
        if k['quantity'] != ''
          if k['action_id'] == '4' #adjustment logic
            if k['quantity'].to_i > k['oldquant'].to_i
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => (k['quantity'].to_i-k['oldquant'].to_i), :loc2 => k['loc1'], :group_id => user.group_id, :count_id => count)
              @transaction.save
            elsif k['quantity'].to_i < k['oldquant'].to_i
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => (k['oldquant'].to_i-k['quantity'].to_i), :loc1 => k['loc1'], :group_id => user.group_id, :count_id => count)
              @transaction.save
            else
            end
          else
              @transaction = Transaction.new(:date => k['date'], :item_id => k['item_id'], :action_id => k['action_id'], :quantity => (k['oldquant'].to_i-k['quantity'].to_i), :loc1 => k['loc1'], :loc2 => k['loc2'], :group_id => user.group_id, :count_id => count)
              @transaction.save
          end
        else
        end
    end    


  
end
