class Item < ActiveRecord::Base
    has_many :transactions, :dependent => :destroy
    belongs_to :group
    has_many :counts, :dependent => :destroy
    scope :owned, ->(user) { where("group_id = ?", user.group_id) }
    scope :active, -> {where("active = ?", true)}
  scope :counted, ->(show) {joins(:counts).where(counts:{show_id:show.id})}
    
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
