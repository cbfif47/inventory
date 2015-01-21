class Item < ActiveRecord::Base
    has_many :transactions
    belongs_to :group
    
  def name_with_sub
    "#{name} #{sub}"
  end

  def self.remaining(item, location)
    Transaction.remain(item.id, location)
  end
  
  def self.hassome(location)
    where("? > 0", self.remaining(location))
  end
end
