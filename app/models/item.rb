class Item < ActiveRecord::Base
    has_many :transactions
    
def name_with_sub
    "#{name} #{sub}"

end

end
