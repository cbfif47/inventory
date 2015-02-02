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
    Transaction.remain(self.id, location)
  end
  
  def hassome(location)
    self.remaining(location) > 0
  end
  
      
  
end
