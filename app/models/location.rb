class Location < ActiveRecord::Base
    belongs_to :group
    scope :owned, ->(user) { where("group_id = ?", user.group_id) }
    scope :active, -> {where("active = ?", true)}
  
  def self.primary(user)
    self.where("available = ? AND group_id = ?", true, user.group_id).first
  end
  
  def others(user)
    Location.where("id != ? AND group_id = ?", self.id, user.group_id)
  end
end
