class Count < ActiveRecord::Base
  belongs_to :show
  belongs_to :item
  has_many :transactions, :dependent => :destroy
  
  def self.make_batch(params, user)
        params.each do |k,v|
        if k['quantity'] != ''   
          if Show.find_by(id:k['show_id']).tour.group_id == user.group_id
          @count = Count.new(:show_id => k['show_id'], :item_id => k['item_id'], :quantity => (k['quantity'].to_i), :rate => k['rate'], :out => k['out'])
          @count.save
            Transaction.make_batch(k,v, user, @count.id)
          end
        end
    end    

  end

  def find_out
    Count.find_by(item_id: self.item_id, show_id: self.show_id, out: true)
  end
  

end


