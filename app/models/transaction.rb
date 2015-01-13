class Transaction < ActiveRecord::Base
  belongs_to :item
  belongs_to :action
end
