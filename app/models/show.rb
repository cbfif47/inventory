class Show < ActiveRecord::Base
  include Ownable
  belongs_to :tour
  has_many :counts, :dependent => :destroy
  scope :hascounts, ->(user) { joins(:counts).where("counts.quantity > ? AND shows.group_id = ?",0, user.group_id).uniq.order(date: :desc) }
  
  def dateandvenue
    "#{date} #{venue}"
  end
end
