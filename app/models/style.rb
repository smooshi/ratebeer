class Style < ActiveRecord::Base
  has_many :beers
  include ApplicationHelper

  def average_rating
    if beers.count > 0
        summa = 0
        beers.each do |beer|
          if beer.ratings.count > 0
            summa += beer.ratings.map { |h| h[:score] }.sum/beer.ratings.count
          end
        end
        return summa/beers.count
    else
      return 0
    end
  end

  def self.top(n)
    return Style.all.sort_by(&:average_rating).reverse.first(n)
  end
end
