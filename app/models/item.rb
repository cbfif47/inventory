class Item < ActiveRecord::Base
    has_many :transactions
    belongs_to :group
    scope :owned, ->(user) { where("group_id = ?", user.group_id) }
    scope :active, -> {where("active = ?", true)}
    
  def name_with_sub
    "#{name} #{sub}"
  end

  def remaining(location)
    Transaction.remain(self.id, location)
  end
  
  def hassome(location)
    self.remaining(location) > 0
  end
  
      
  
end
