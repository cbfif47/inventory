class Item < ActiveRecord::Base
    has_many :transactions
    belongs_to :group
    
  def name_with_sub
    "#{name} #{sub}"
  end

  def self.remaining(item, location, min=0, max=Transaction.maximum(:id))
    Transaction.remain(item.id, location,min,max)
  end
  
  def self.hassome(location)
    where("? > 0", self.remaining(location))
  end
end
