class Group < ActiveRecord::Base
  has_many :users, :items, :locations, :transactions
end
