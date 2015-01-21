class Preroll < ActiveRecord::Base
  belongs_to :action_type
  belongs_to :group
end
