module Ownable
  extend ActiveSupport::Concern

  included do
    belongs_to :group
    scope :owned, ->(user) { where("group_id = ?", user.group_id) }
  end

  module ClassMethods
    
  end
end