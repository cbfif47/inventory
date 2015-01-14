class Transaction < ActiveRecord::Base
  belongs_to :item
  belongs_to :action
    
    def net
        if quantity 
            quantity * action.impact 
        else
        0
        end
    end
end
