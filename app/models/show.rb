class Show < ActiveRecord::Base
  belongs_to :group
  has_many :counts, :dependent => :destroy
end
