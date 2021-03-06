class Show < ActiveRecord::Base
  include Ownable
  belongs_to :tour
  has_many :counts, :dependent => :destroy
  has_many :transactions
  scope :hascounts, ->(user) { joins(:counts).where("counts.quantity > ? AND shows.group_id = ?",0, user.group_id).uniq.order(date: :desc) }
  scope :ontour, ->(tour) {where(tour_id:tour.id)}
  
  def dateandvenue
    "#{date} #{venue}"
  end
end
