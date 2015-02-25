class Show < ActiveRecord::Base
  has_many :counts, :dependent => :destroy
  has_many :guests, :dependent => :destroy
  has_many :transactions
  belongs_to :tour
  accepts_nested_attributes_for :guests, allow_destroy: true, :reject_if => :all_blank
  scope :owned, ->(user) { joins(:tour).where(tours:{group_id:user.group_id}) }
  scope :hascounts, -> { joins(:counts).where("counts.quantity > 0").uniq.order(date: :desc) }
  scope :ontour, ->(tour) {where(tour_id:tour.id)}
  scope :relevant, -> {where("date >= ? ", Date.today - 7)}
  scope :irrelevant, -> {where("date < ? ", Date.today - 7)}
  
  def dateandvenue
    "#{date} #{venue}"
  end

  
end
