class Tour < ActiveRecord::Base
  include Ownable
  has_many :shows
  accepts_nested_attributes_for :shows
end
