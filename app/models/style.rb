class Style < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers
  include ApplicationHelper, Average

  def self.top(n)
    return Style.all.sort_by(&:average_rating).reverse.first(n)
  end
end
