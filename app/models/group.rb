class Group < ActiveRecord::Base
  has_many :users, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
  has_many :shows, :dependent => :destroy
  has_many :counts, :dependent => :destroy
  has_many :tours, :dependent => :destroy
end
