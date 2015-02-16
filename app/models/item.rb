class Item < ActiveRecord::Base
    include Ownable
    has_many :transactions, :dependent => :destroy
    has_many :counts, :dependent => :destroy
    scope :active, -> {where("active = ?", true)}
    scope :counted_in, ->(show) {joins(:counts).where(counts:{show_id:show.id, out:false})}
    scope :counted_out, ->(show) {joins(:counts).where(counts:{show_id:show.id, out:true})}
  
  def name_with_sub
    "#{name} #{sub}"
  end

  def remaining(location)
    Transaction.where("item_id = ? AND loc2 = ?", self.id, location).sum(:quantity) - Transaction.where("item_id = ? AND loc1 = ?", self.id, location).sum(:quantity)
  end
  
  def hassome(location)
    self.remaining(location) > 0
  end
  
  def find_comps(show)
    Transaction.where(item_id:self.id, show_id:show.id, action:5).sum(:quantity)
  end
     
  def find_transfers(show)
    Transaction.where(item_id:self.id, show_id:show.id, action:3).sum(:quantity)
  end
  
end
