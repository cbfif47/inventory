class Tour < ActiveRecord::Base
  include Ownable
  has_many :shows, :dependent => :destroy
  has_many :transactions, :through => :shows
  accepts_nested_attributes_for :shows
end
