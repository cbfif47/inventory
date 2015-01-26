class Count < ActiveRecord::Base
  belongs_to :show
  belongs_to :item
  
    def self.make_batch(params)
        params.each do |k,v|
        if k['in'] != ''          
          @count = Count.new(:show_id => k['show_id'], :item_id => k['item_id'], :in => (k['in'].to_i))
          @count.save
        else
        end
    end    

  end
end
