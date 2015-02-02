class Tour < ActiveRecord::Base
  include Ownable
  has_many :shows
end
