class Group < ActiveRecord::Base
  has_many :users
  has_many :items
  has_many :locations
  has_many :transactions
end
