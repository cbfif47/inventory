class Location < ActiveRecord::Base
    include Ownable
    scope :active, -> {where("active = ?", true)}
  
  def self.primary(user)
    self.where("available = ? AND group_id = ?", true, user.group_id).first
  end
  
  def others(user)
    Location.where("id != ? AND group_id = ? AND active = ?", self.id, user.group_id, true)
  end
end
