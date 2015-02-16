class Location < ActiveRecord::Base
    include Ownable
    scope :active, -> {where("active = ?", true)}
  
  def self.prime(user)
    self.where(primary:true,group_id:user.group_id).first
  end
  
  def others(user)
    Location.where("id != ? AND group_id = ? AND active = ?", self.id, user.group_id, true)
  end
end
