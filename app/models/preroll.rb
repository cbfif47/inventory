class Preroll < ActiveRecord::Base
  belongs_to :action_type
  belongs_to :group
  scope :owned, ->(user) { where("group_id = ?", user.group_id).first }
end
